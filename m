Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59B345FC876
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Oct 2022 17:34:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbiJLPeB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Oct 2022 11:34:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbiJLPd7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Oct 2022 11:33:59 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF0718263D;
        Wed, 12 Oct 2022 08:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=FcG94y6UwISA+lHDHdY/DVnnCmrPksg3e4hWI/ZibTM=; b=YaTX83ygihnOx5Ts65HIdrwQVB
        9Lv6VMb2rGWVo9xcK4n/yxLP++T456Hk7YQxtITsYrLJRAE01q3P8uun44DcMaZMULFH3qSVcS8/i
        WHB0eWPp0wk9gInhBkI584d1uCaCz4jRWaJ614cX+TkjRWMeDYeghZPbfVcDcfCLYu9cXvfumQKRM
        DhyKrFfDQgwB8is3XwixEalLm5zRC+fywwlGkn5+w7H8oRuViHsdW6tgOJmwzaOSi8GsfupFVgjtv
        DZS9B3qzGdRe6pZRki339+Iu+qb8oPOoXn/dg5KcNcTHelcUeJ1JnX+yQi7wahAmVc69wIsGaL5cO
        Tw77G0ZQ==;
Received: from 201-43-120-40.dsl.telesp.net.br ([201.43.120.40] helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1oidjz-000HPZ-Ay; Wed, 12 Oct 2022 17:33:51 +0200
Message-ID: <267ccf8f-1fea-7648-ec2b-e7f4ae822ae4@igalia.com>
Date:   Wed, 12 Oct 2022 12:33:36 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH 2/8] pstore: Expose kmsg_bytes as a module parameter
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        kernel-dev@igalia.com, kernel@gpiccoli.net, anton@enomsg.org,
        ccross@android.com, tony.luck@intel.com
References: <20221006224212.569555-1-gpiccoli@igalia.com>
 <20221006224212.569555-3-gpiccoli@igalia.com> <202210061628.76EAEB8@keescook>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <202210061628.76EAEB8@keescook>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 06/10/2022 20:32, Kees Cook wrote:
> [...]
> Doing a mount will override the result, so I wonder if there should be
> two variables, etc... not a concern for the normal use case.
> 
> Also, I've kind of wanted to get rid of a "default" for this and instead
> use a value based on the compression vs record sizes, etc. But I didn't
> explore it.
> 

For some reason I forgot to respond that, sorry!

I didn't understand exactly how the mount would override things; I've
done some tests:

(1) booted with the new kmsg_bytes module parameter set to 64k, and it
was preserved across multiple mount/umount cycles.

(2) When I manually had "-o kmsg_bytes=16k" set during the mount
operation, it worked as expected, setting the thing to 16k (and
reflecting in the module parameter, as observed in /sys/modules).

Maybe I'm missing something?

Now, regarding the idea of setting that as a function of
compression/record_sizes, I feel it makes sense and could be worked,
like a heuristic right?

In the end, if you think properly, what is the purpose of kmsg_bytes?
Wouldn't make sense to just fill the record_size with the maximum amount
of data it can handle? Of course there is the partitioning thing, but in
the end kmsg_bytes seems a mechanism to _restrict_ the data collection,
so maybe the default would be a value that means "save whatever you can
handle" (maybe 0), and if the parameter/mount option is set, then pstore
would restrict the saved size.
Thoughts?

Thanks,


Guilherme
