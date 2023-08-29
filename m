Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E41BA78CD8F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Aug 2023 22:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239059AbjH2U3n (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Aug 2023 16:29:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232406AbjH2U3L (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Aug 2023 16:29:11 -0400
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D172FC;
        Tue, 29 Aug 2023 13:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=N/RKZqAMsS7s2pycnUM7y4cDHehHwANsRwI/KiPRlTQ=; b=bvInlPJrZEfYltxyOCnxx/bI8n
        LB4kkLp7cD1p/iWT19Awg5OTOx8MpiiwV8kuGEkzQp66h8SRueNF0mEYj7Xe1UK1pZ27kcFXsbxbU
        3xEjWzmm4NWR6Ps2TsD5384XhvpjOTSXV5xt9Fbhgbf3mM7FJl8jANr1hdaTFZnOuwz5IrjW8J5sD
        yHVYihjwOCBRmgsUvxqNbeRFw1aaZ8PPiO0v6c5d4IJBxp5BosuJGQ246it/tMjtyOPSV7xUKz6my
        mWhiOpBvDyNQCjLXShWRyVGnQFd90tdtQRsgh4tD8TXTR3KhNJ44XpgrZ4qij5n2TOAt0Ps2Fj22b
        jj1OtwKA==;
Received: from [187.116.122.196] (helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1qb5KY-00Gypn-U3; Tue, 29 Aug 2023 22:28:55 +0200
Message-ID: <9bd1260f-fe69-45ba-1a37-f9e422809bff@igalia.com>
Date:   Tue, 29 Aug 2023 17:28:46 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/3] btrfs: Introduce the single-dev feature
Content-Language: en-US
To:     anand.jain@oracle.com, dsterba@suse.com, josef@toxicpanda.com
Cc:     clm@fb.com, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, kernel@gpiccoli.net,
        kernel-dev@igalia.com, david@fromorbit.com, kreijack@libero.it,
        johns@valvesoftware.com, ludovico.denittis@collabora.com,
        quwenruo.btrfs@gmx.com, wqu@suse.com, vivek@collabora.com
References: <20230803154453.1488248-1-gpiccoli@igalia.com>
 <20230803154453.1488248-3-gpiccoli@igalia.com>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <20230803154453.1488248-3-gpiccoli@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 03/08/2023 12:43, Guilherme G. Piccoli wrote:
> [...]
>  fs/btrfs/disk-io.c         | 19 +++++++-
>  fs/btrfs/fs.h              |  3 +-
>  fs/btrfs/ioctl.c           | 18 +++++++
>  fs/btrfs/super.c           |  8 ++--
>  fs/btrfs/volumes.c         | 97 ++++++++++++++++++++++++++++++--------
>  fs/btrfs/volumes.h         |  3 +-
>  include/uapi/linux/btrfs.h |  7 +++
>  7 files changed, 127 insertions(+), 28 deletions(-)
> 

Hi folks, while working the xfstests for this case, I've noticed the
single-dev feature is not exposed in sysfs! Should we make it available
there?

A quick change here made me see it there, but it sticks to value 0 ...
maybe I'm not really aware of how the sysfs/features directory should
work, hence I appreciate if you could enlighten me if makes sense to
have this feature there (and if it's OK showing zero or should flip in
case a device makes use of the feature, maybe?).

Thanks in advance,


Guilherme
