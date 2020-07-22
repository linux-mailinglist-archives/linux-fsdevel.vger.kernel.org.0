Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D73F22A033
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jul 2020 21:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732178AbgGVTkY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Jul 2020 15:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726322AbgGVTkV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Jul 2020 15:40:21 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4472CC0619DC
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jul 2020 12:40:21 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id p1so1499476pls.4
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jul 2020 12:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=jjUf3A9HubTVaUqe7Zad+MUemnjZyICfz18It9oZSwM=;
        b=BtZ9Nvf8isLyQCQ50XpXD/ebRCdBjkHCCGnxVM0OZAVUpANRBBMkjIj06Zdw9/XpBn
         ZFD8aNoO8CrwWK2+N4nmMD0rTFkdF72k74MsJNFZWuktshu5ucg9wp2qUVlDzWfUY4Ja
         ol6MqQXlLRetbAhUkjy41VWkXgnqEDPN3tA18=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=jjUf3A9HubTVaUqe7Zad+MUemnjZyICfz18It9oZSwM=;
        b=bOO9qZ45NdXQFHZitwfiybEqOOl68bAirmaAMJDsZ4qKjYV478Rn8Eb2hZL5aAsXks
         eMKulfEVuR1kYjo+K7hjPSHd0om/A5Eb0BcRDnestPjrdjSeBIJZJtv0lio5YKaxIvdo
         BZYANFAZnn0RO1XNBcsallNL1B3REe++oevjucbA0p1YdbIWUBbQIUZrireBF5OarXMU
         Bg6JB+RKr0B9IKV2QtChcGOx9d6/4Dz1eDPCAqTTQm81iyPO+oCdzpfHMHZ+d2zOVmyw
         aLJX3QL7ZfH2dAsvmAJ/kkft0K98brUo56zoH6sIxGN2JiHabvNU94AZu8zS7ggMAR/s
         1EkQ==
X-Gm-Message-State: AOAM531dC9hA0fjEW4oTEBlC+jJPo/zI+z5wW33oNuLp2Qa2Gc0A53si
        OaCy3XRqgbMvlu1TWGGWLc6h6A==
X-Google-Smtp-Source: ABdhPJyT2VSdLIe8tOpWuzfYoIvgn4i+cMVfKxosGUgPymW4NU2ZBedNm+ZTGrz2uSKWm+z7tIxFEg==
X-Received: by 2002:a17:90b:338d:: with SMTP id ke13mr906409pjb.60.1595446820815;
        Wed, 22 Jul 2020 12:40:20 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 38sm420287pgu.61.2020.07.22.12.40.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2020 12:40:19 -0700 (PDT)
Date:   Wed, 22 Jul 2020 12:40:19 -0700
From:   Kees Cook <keescook@chromium.org>
To:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc:     Thibaut Sautereau <thibaut.sautereau@clip-os.org>,
        linux-kernel@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christian Heimes <christian@python.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Deven Bowers <deven.desai@linux.microsoft.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Eric Chiang <ericchiang@google.com>,
        Florian Weimer <fweimer@redhat.com>,
        James Morris <jmorris@namei.org>, Jan Kara <jack@suse.cz>,
        Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Matthew Garrett <mjg59@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mickael.salaun@ssi.gouv.fr>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Philippe =?iso-8859-1?Q?Tr=E9buchet?= 
        <philippe.trebuchet@ssi.gouv.fr>,
        Scott Shell <scottsh@microsoft.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Steve Dower <steve.dower@python.org>,
        Steve Grubb <sgrubb@redhat.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>,
        Vincent Strubel <vincent.strubel@ssi.gouv.fr>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v6 5/7] fs,doc: Enable to enforce noexec mounts or file
 exec through O_MAYEXEC
Message-ID: <202007221239.E00125F019@keescook>
References: <20200714181638.45751-1-mic@digikod.net>
 <20200714181638.45751-6-mic@digikod.net>
 <202007151312.C28D112013@keescook>
 <35ea0914-7360-43ab-e381-9614d18cceba@digikod.net>
 <20200722161639.GA24129@gandi.net>
 <efb88aab-f9f9-4b66-e7ab-3aa054eec96e@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <efb88aab-f9f9-4b66-e7ab-3aa054eec96e@digikod.net>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 22, 2020 at 09:04:28PM +0200, Mickaël Salaün wrote:
> 
> On 22/07/2020 18:16, Thibaut Sautereau wrote:
> > On Thu, Jul 16, 2020 at 04:39:14PM +0200, Mickaël Salaün wrote:
> >>
> >> On 15/07/2020 22:37, Kees Cook wrote:
> >>> On Tue, Jul 14, 2020 at 08:16:36PM +0200, Mickaël Salaün wrote:
> >>>> @@ -2849,7 +2855,7 @@ static int may_open(const struct path *path, int acc_mode, int flag)
> >>>>  	case S_IFLNK:
> >>>>  		return -ELOOP;
> >>>>  	case S_IFDIR:
> >>>> -		if (acc_mode & (MAY_WRITE | MAY_EXEC))
> >>>> +		if (acc_mode & (MAY_WRITE | MAY_EXEC | MAY_OPENEXEC))
> >>>>  			return -EISDIR;
> >>>>  		break;
> >>>
> >>> (I need to figure out where "open for reading" rejects S_IFDIR, since
> >>> it's clearly not here...)
> > 
> > Doesn't it come from generic_read_dir() in fs/libfs.c?
> > 
> >>>
> >>>>  	case S_IFBLK:
> >>>> @@ -2859,13 +2865,26 @@ static int may_open(const struct path *path, int acc_mode, int flag)
> >>>>  		fallthrough;
> >>>>  	case S_IFIFO:
> >>>>  	case S_IFSOCK:
> >>>> -		if (acc_mode & MAY_EXEC)
> >>>> +		if (acc_mode & (MAY_EXEC | MAY_OPENEXEC))
> >>>>  			return -EACCES;
> >>>>  		flag &= ~O_TRUNC;
> >>>>  		break;
> >>>
> >>> This will immediately break a system that runs code with MAY_OPENEXEC
> >>> set but reads from a block, char, fifo, or socket, even in the case of
> >>> a sysadmin leaving the "file" sysctl disabled.
> >>
> >> As documented, O_MAYEXEC is for regular files. The only legitimate use
> >> case seems to be with pipes, which should probably be allowed when
> >> enforcement is disabled.
> > 
> > By the way Kees, while we fix that for the next series, do you think it
> > would be relevant, at least for the sake of clarity, to add a
> > WARN_ON_ONCE(acc_mode & MAY_OPENEXEC) for the S_IFSOCK case, since a
> > socket cannot be open anyway?

If it's a state that userspace should never be able to reach, then yes,
I think a WARN_ON_ONCE() would be nice.

> We just did some more tests (for the next patch series) and it turns out
> that may_open() can return EACCES before another part returns ENXIO.
> 
> As a reminder, the next series will deny access to block devices,
> character devices, fifo and socket when opened with O_MAYEXEC *and* if
> any policy is enforced (via the sysctl).
> 
> The question is then: do we prefer to return EACCES when a policy is
> enforced (on a socket), or do we stick to the ENXIO? The EACCES approach
> will be more consistent with devices and fifo handling, and seems safer
> (belt and suspenders) thought.

I think EACCES is correct for these cases, since it's a new flag, etc.

-- 
Kees Cook
