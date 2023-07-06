Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 799EE74A719
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jul 2023 00:33:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231366AbjGFWda (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jul 2023 18:33:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbjGFWd2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jul 2023 18:33:28 -0400
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5C021FEC;
        Thu,  6 Jul 2023 15:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=6ApKehk9sjLnBL9KOum4DRetfpp0w+Ls/P37y4uhWHc=; b=Ej/N7xjW/w9slmXCXVLOKFE6Wc
        jBcQjoFRrct+YDKNNxs772xM6VyY3AfoMhJsNELKpHvrFC6HEu9mkLjFbSiMB0hPmhmJ0c+NV6v1N
        DVcRbEdwc+8KTHn4ULL4Y2u7WKxSDbx/rXhOc1/oWO8JJWosYYUV7wRZKuLkaHXTmgT+oTqhOOiCa
        3Zpbgh+FOmcKRtBWdGBqHM6OK7QLb1D4vPvGrdti5tcQPjMpQRGx1TJW1v0PZMCx0KdHTcsFafQVH
        SjkPaLNm1LXG+nJm4hCrZLc3+esdwr/3VGhoNlrQjv01ivql96WHCzRxMztO20XgqN9zMH1NvL3ju
        gXDlZC6g==;
Received: from [191.205.188.225] (helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1qHXWy-009fM0-Qw; Fri, 07 Jul 2023 00:32:57 +0200
Message-ID: <909cd44d-1f6a-2746-43fc-cb39676d17dd@igalia.com>
Date:   Thu, 6 Jul 2023 19:32:50 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/2] btrfs: Introduce the virtual_fsid feature
Content-Language: en-US
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>,
        dsterba@suse.com, Anand Jain <anand.jain@oracle.com>
Cc:     clm@fb.com, josef@toxicpanda.com, linux-fsdevel@vger.kernel.org,
        kernel@gpiccoli.net, kernel-dev@igalia.com, vivek@collabora.com,
        ludovico.denittis@collabora.com, johns@valvesoftware.com,
        linux-btrfs@vger.kernel.org
References: <20230504170708.787361-1-gpiccoli@igalia.com>
 <20230504170708.787361-2-gpiccoli@igalia.com>
 <2892ff0d-9225-07b7-03e4-a3c96d0bff59@gmx.com>
 <bc897780-2c81-fe1f-a8d4-148a08962a20@igalia.com>
 <0d6dc2f3-75a5-bc72-f3b5-2a3749db1683@gmx.com>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <0d6dc2f3-75a5-bc72-f3b5-2a3749db1683@gmx.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 05/07/2023 21:53, Qu Wenruo wrote:
> [...]
> Personally speaking, I would go one of the following solution:
> 
> - Keep the sysfs, but adds a refcount to the sysfs related structures
>    If we still go register the sysfs interface, then we have to keep a
>    refcount, or any of the same fsid got unmounted, we would remove the
>    whole sysfs entry.
> 
> - Skip the sysfs entry completely for any fs with the new compat_ro flag
>    This would your idea (III), but the sysfs interface itself is not that
>    critical (we add and remove entries from time to time), so I believe
>    it's feasible to hide the sysfs for certain features.
> 

Hi Qu, thanks for you prompt response.
I've been trying to mess with btrfs sysfs to allow two same fsid
co-existing, without success. For each corner case I handle, two more
show-up heh

Seems quite tricky and error-prone to have this "special-casing" of
sysfs just to accommodate this feature.

Are you strongly against keeping the previous idea, of a spoofed/virtual
fsid, but applied to the compat_ro single_dev idea? This way, all of
this sysfs situation (and other potentially hidden corner cases) would
be avoided. That's like my suggestion (I).

David / Anand, any thoughts/ideas? Thanks in advance!


>> [...]
>> Also, one last question/confirmation: you mentioned that "The better
>> method to enable/disable a feature should be mkfs" - you mean the same
>> way mkfs could be used to set features like "raid56" or "no-holes"?
> 
> Yes.
> 
>> [...]
> I'm not familiar with metadata_uuid, but there are similar features like
> seeding, which is only available in btrfstune, but not in mkfs.
> 
> It's not that uncommon, but yeah, you have found something we should
> improve on.
> 

Thanks for confirming, I could implement it in both mkfs and btrfstune -
seems the more consistent path.
Cheers,


Guilherme
