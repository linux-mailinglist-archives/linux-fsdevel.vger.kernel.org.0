Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 696FE72E1BE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jun 2023 13:35:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbjFMLfH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Jun 2023 07:35:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239438AbjFMLew (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Jun 2023 07:34:52 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF7B5CD;
        Tue, 13 Jun 2023 04:34:50 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 6B3451FD91;
        Tue, 13 Jun 2023 11:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1686656089; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BTbTiUGilqHur9sl4tAQ10e6uWfud6O0TKx7z1X8AGk=;
        b=M9ee6xDEXUBuyeXDG8T3ZF7ZDW7HIyxKnX6b1C55ByQ1WAtvj88qXkJQJgWhHG/pkbWFKP
        dZLTzIDUdqyBu8LTYixd3w6gtbv5IjvEum4XQInRwd4BO0PVB4khQm9jk3x59C1QUvCjk9
        Wev+UPnnE8FH04BCzy2NJwmtgLAo3Hk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1686656089;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BTbTiUGilqHur9sl4tAQ10e6uWfud6O0TKx7z1X8AGk=;
        b=Kaqqm2oxupWuCOg2/Qtz9CbRjdQPtmbtBSzSsbn9ElY7CiG00/wJ8yQonzFnBNJht3dOFS
        DkvD8ntldj9zdbDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 58C8813345;
        Tue, 13 Jun 2023 11:34:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id V1yhFVlUiGQiFwAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 13 Jun 2023 11:34:49 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id E634AA0717; Tue, 13 Jun 2023 13:34:48 +0200 (CEST)
Date:   Tue, 13 Jun 2023 13:34:48 +0200
From:   Jan Kara <jack@suse.cz>
To:     Colin Walters <walters@verbum.org>
Cc:     Bart Van Assche <bvanassche@acm.org>, Jan Kara <jack@suse.cz>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Theodore Ts'o <tytso@mit.edu>, yebin <yebin@huaweicloud.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] block: Add config option to not allow writing to mounted
 devices
Message-ID: <20230613113448.5txw46hvmdjvuoif@quack3>
References: <20230612161614.10302-1-jack@suse.cz>
 <20230612162545.frpr3oqlqydsksle@quack3>
 <2f629dc3-fe39-624f-a2fe-d29eee1d2b82@acm.org>
 <a6c355f7-8c60-4aab-8f0c-5c6310f9c2a8@betaapp.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a6c355f7-8c60-4aab-8f0c-5c6310f9c2a8@betaapp.fastmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 12-06-23 14:52:54, Colin Walters wrote:
> On Mon, Jun 12, 2023, at 1:39 PM, Bart Van Assche wrote:
> > On 6/12/23 09:25, Jan Kara wrote:
> >> On Mon 12-06-23 18:16:14, Jan Kara wrote:
> >>> Writing to mounted devices is dangerous and can lead to filesystem
> >>> corruption as well as crashes. Furthermore syzbot comes with more and
> >>> more involved examples how to corrupt block device under a mounted
> >>> filesystem leading to kernel crashes and reports we can do nothing
> >>> about. Add config option to disallow writing to mounted (exclusively
> >>> open) block devices. Syzbot can use this option to avoid uninteresting
> >>> crashes. Also users whose userspace setup does not need writing to
> >>> mounted block devices can set this config option for hardening.
> >>>
> >>> Link: https://lore.kernel.org/all/60788e5d-5c7c-1142-e554-c21d709acfd9@linaro.org
> >>> Signed-off-by: Jan Kara <jack@suse.cz>
> >> 
> >> Please disregard this patch. I had uncommited fixups in my tree. I'll send
> >> fixed version shortly. I'm sorry for the noise.
> >
> > Have alternatives been configured to making this functionality configurable
> > at build time only? How about a kernel command line parameter instead of a
> > config option?
> 
> It's not just syzbot here; at least once in my life I accidentally did
> `dd if=/path/to/foo.iso of=/dev/sda` when `/dev/sda` was my booted disk
> and not the target USB device.  I know I'm not alone =)

Yeah, so I'm not sure we are going to protect against this particular case.
I mean it is not *that* uncommon to alter partition table of /dev/sda while
/dev/sda1 is mounted. And for the kernel it is difficult to distinguish
this and your mishap.

> There's a lot of similar accidental-damage protection from this.  Another
> stronger argument here is that if one has a security policy that
> restricts access to filesystem level objects, if a process can somehow
> write to a mounted block device, it effectively subverts all of those
> controls. 

Well, there are multiple levels of protection that I can think of:

1) If user can write some image and make kernel mount it.
2) If user can modify device content while mounted (but not buffer cache
of the device).
3) If user can modify buffer cache of the device while mounted.

3) is the most problematic and effectively equivalent to full machine
control (executing arbitrary code in kernel mode) these days.  For 1) and
2) there are reasonable protection measures the filesystem driver can take
(and effectively you cannot escape these problems if you allow attaching
untrusted devices such as USB sticks) so they can cause DoS but we should
be able to prevent full machine takeover in the filesystem code.

So this patch is mainly aimed at forbiding 3).

> Right now it looks to me we're invoking devcgroup_check_permission pretty
> early on; maybe we could extend the device cgroup stuff to have a new
> check for write-mounted, like
> 
> ```
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
> index c994ff5b157c..f2af33c5acc1 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -6797,6 +6797,7 @@ enum {
>  	BPF_DEVCG_ACC_MKNOD	= (1ULL << 0),
>  	BPF_DEVCG_ACC_READ	= (1ULL << 1),
>  	BPF_DEVCG_ACC_WRITE	= (1ULL << 2),
> +	BPF_DEVCG_ACC_WRITE_MOUNTED	= (1ULL << 3),
>  };
>  
>  enum {
> ```
> 
> ?  But probably this would need to be some kind of opt-in flag to avoid
> breaking existing bpf progs?
> 
> If it was configurable via the device cgroup, then it's completely
> flexible from userspace; most specifically including supporting some
> specially privileged processes from doing it if necessary.

I kind of like the flexibility of device cgroups but it does not seem to
fit well with my "stop unactionable syzbot reports" usecase and doing the
protection properly would mean that we now need to create way to approve
access for all the tools that need this. So I'm not against this but I'd
consider this "future extension possibility" :).

> Also, I wonder if we should also support restricting *reads* from mounted
> block devices?

I don't see a strong usecase for this. Why would mounted vs unmounted
matter here?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
