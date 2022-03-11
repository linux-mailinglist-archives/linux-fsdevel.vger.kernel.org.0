Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECA594D5E54
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Mar 2022 10:24:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346526AbiCKJXp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Mar 2022 04:23:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345021AbiCKJXk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Mar 2022 04:23:40 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D90B3B1;
        Fri, 11 Mar 2022 01:22:35 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3E48A1F381;
        Fri, 11 Mar 2022 09:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1646990554; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0izCbKy2PPDXTj3zqLWTj1ez7s4mrzmIYx97ZIN4SaQ=;
        b=pcQn5HK48a7pGy1Uie5Q/uhC9zp+X98MWoSUrVTBJ9+4GGdOqVavasGuHcy+EPFuUWlyhU
        PvayG78vRTejFQ8Ggi7AdDQzJ0QelHbK2ZxYAXC2kTLBigaHCxBHik28X2LHo7Phgtz2BF
        OQRf4lU00xDvtTbDF94osF7v3fM02Pg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1646990554;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0izCbKy2PPDXTj3zqLWTj1ez7s4mrzmIYx97ZIN4SaQ=;
        b=J+vUxs6CxNl4yRwPAXVmhazKXZenTR2kKtNXQWKOrgangeXmQvkUHtd/vdrT6pABlnIF72
        Z9upYF45BJRfLYBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 019A613A82;
        Fri, 11 Mar 2022 09:22:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 0QF6OtkUK2L/UwAAMHmgww
        (envelope-from <vkarasulli@suse.de>); Fri, 11 Mar 2022 09:22:33 +0000
Date:   Fri, 11 Mar 2022 10:22:32 +0100
From:   Vasant Karasulli <vkarasulli@suse.de>
To:     Namjae Jeon <linkinjeon@kernel.org>
Cc:     David Disseldorp <ddiss@suse.de>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Takashi Iwai <tiwai@suse.de>
Subject: Re: [PATCH v2 2/2] exfat currently unconditionally strips trailing
 periods '.' when performing path lookup, but allows them in the filenames
 during file creation. This is done intentionally, loosely following Windows
 behaviour and specifications which state:
Message-ID: <YisU2FA7EBeguwN5@vasant-suse>
References: <20220310142455.23127-1-vkarasulli@suse.de>
 <20220310142455.23127-3-vkarasulli@suse.de>
 <20220310210633.095f0245@suse.de>
 <CAKYAXd_ij3WqJHQZvH458XRwLBtboiJnr-fK0hVPDi_j_8XDZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKYAXd_ij3WqJHQZvH458XRwLBtboiJnr-fK0hVPDi_j_8XDZQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fr 11-03-22 18:03:57, Namjae Jeon wrote:
> 2022-03-11 5:06 GMT+09:00, David Disseldorp <ddiss@suse.de>:
> > Thanks for reworking these changes, Vasant.
> >
> > Please trim the 1/2 and 2/2 patch subjects down to around 50 chars
> > (including a "exfat: " prefix), with the details moved into the commit
> > message body...
> >
> > On Thu, 10 Mar 2022 15:24:55 +0100, Vasant Karasulli wrote:
> >
> >>   #exFAT
> >>   The concatenated file name has the same set of illegal characters as
> >>   other FAT-based file systems (see Table 31).
> >>
> >>   #FAT
> >>   ...
> >>   Leading and trailing spaces in a long name are ignored.
> >>   Leading and embedded periods are allowed in a name and are stored in
> >>   the long name. Trailing periods are ignored.
> >>
> >> Note: Leading and trailing space ' ' characters are currently retained
> >> by Linux kernel exfat, in conflict with the above specification.
> >
> > I think it makes sense to mention your findings from the Windows tests
> > here. E.g. "Windows 10 also retains leading and trailing space
> > characters".
> Windows 10 do also strip them. So you can make another patch to strip
> it as well as trailing periods.
Actually I found contradicting behavior between Window 10 File Explorer and
Commandline. Commandline seems to strip trailing spaces, but File Explorer
doesn't.

> >
> >> Some implementations, such as fuse-exfat, don't perform path trailer
> >> removal. When mounting images which contain trailing-dot paths, these
> >> paths are unreachable, e.g.:
> >>
> >>   + mount.exfat-fuse /dev/zram0 /mnt/test/
> >>   FUSE exfat 1.3.0
> >>   + cd /mnt/test/
> >>   + touch fuse_created_dots... '  fuse_created_spaces  '
> >>   + ls -l
> >>   total 0
> >>   -rwxrwxrwx 1 root 0 0 Aug 18 09:45 '  fuse_created_spaces  '
> >>   -rwxrwxrwx 1 root 0 0 Aug 18 09:45  fuse_created_dots...
> >>   + cd /
> >>   + umount /mnt/test/
> >>   + mount -t exfat /dev/zram0 /mnt/test
> >>   + cd /mnt/test
> >>   + ls -l
> >>   ls: cannot access 'fuse_created_dots...': No such file or directory
> >>   total 0
> >>   -rwxr-xr-x 1 root 0 0 Aug 18 09:45 '  fuse_created_spaces  '
> >>   -????????? ? ?    ? ?            ?  fuse_created_dots...
> >>   + touch kexfat_created_dots... '  kexfat_created_spaces  '
> >>   + ls -l
> >>   ls: cannot access 'fuse_created_dots...': No such file or directory
> >>   total 0
> >>   -rwxr-xr-x 1 root 0 0 Aug 18 09:45 '  fuse_created_spaces  '
> >>   -rwxr-xr-x 1 root 0 0 Aug 18 09:45 '  kexfat_created_spaces  '
> >>   -????????? ? ?    ? ?            ?  fuse_created_dots...
> >>   -rwxr-xr-x 1 root 0 0 Aug 18 09:45  kexfat_created_dots
> >>   + cd /
> >>   + umount /mnt/test/
> >>
> >> With this change, the "keep_last_dots" mount option can be used to access
> >> paths with trailing periods and disallow creating files with names with
> >> trailing periods. E.g. continuing from the previous example:
> >>
> >>   + mount -t exfat -o keep_last_dots /dev/zram0 /mnt/test
> >>   + cd /mnt/test
> >>   + ls -l
> >>   total 0
> >>   -rwxr-xr-x 1 root 0 0 Aug 18 10:32 '  fuse_created_spaces  '
> >>   -rwxr-xr-x 1 root 0 0 Aug 18 10:32 '  kexfat_created_spaces  '
> >>   -rwxr-xr-x 1 root 0 0 Aug 18 10:32  fuse_created_dots...
> >>   -rwxr-xr-x 1 root 0 0 Aug 18 10:32  kexfat_created_dots
> >
> > It'd be nice to demonstrate "keep_last_dots" creation here as well, e.g.
> >
> >   + echo > kexfat_created_dots_again...
> >   sh: kexfat_created_dots_again...: Invalid argument
> >
> > @Namjae: not sure whether this is what you had in mind for preventing
> > creation of invalid paths. What's your preference?
> Look like what I wanted.
That's great. I will resend the patch after modifying the commit message
as David suggested.
>
> Thanks!
> >
> > Cheers, David
> >

Thanks,
Vasant Karasulli
Kernel generalist
www.suse.com<http://www.suse.com>
[https://www.suse.com/assets/img/social-platforms-suse-logo.png]<http://www.suse.com/>
SUSE - Open Source Solutions for Enterprise Servers & Cloud<http://www.suse.com/>
Modernize your infrastructure with SUSE Linux Enterprise servers, cloud technology for IaaS, and SUSE's software-defined storage.
www.suse.com

