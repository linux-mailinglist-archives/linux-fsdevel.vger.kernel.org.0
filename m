Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27770217BBB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jul 2020 01:36:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728956AbgGGXg1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jul 2020 19:36:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728606AbgGGXg0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jul 2020 19:36:26 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D15A1C08C5E2
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Jul 2020 16:36:24 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id x72so9676881pfc.6
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Jul 2020 16:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=ehrLD1cxXGRyzVehQq1oHHHOmOGHN7pI4vksatqvpYA=;
        b=ZZ/Mz7UuSGKh+eftvFFbUR7WcX2YiqHv9MOKRBM7/2zujfFglzbG50FzHe/7KytweB
         8jLiRR0ul22z9EAQMyl94IB297bW/6zahpg1H+A2giolc852deCSeSniO0B3R2Jboekb
         qNieiOUshfhWIRj/wwrGq7xEse7uGhWJSxBgc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ehrLD1cxXGRyzVehQq1oHHHOmOGHN7pI4vksatqvpYA=;
        b=iYGWaBQ6Bk0fASq7/h9eCRv6aIDI2JVzH1dSjCP5ln8mwX2qMEkL9gZ3vhApn+pvp+
         EPgyveG/jtK92a2DuRmGVla000OvM2QZ5WkHDam/LHn7cm7gQCIUF8J9Bqiit2tgwH5P
         RWgNtjr8Qysuq5Z9O+8tUcHV/gVTAXEbFYkPu/rFjYxYz6wqL8VZnSXQGSFRf4UwnB6q
         7M7Nz+BnIhf7kZfxPTkFNcT80S4BnQl6TxW0tl6XhLbFFYcatVPHgXPLWpvU8ESdWja2
         PmmkCai/Pjip8Ph+nMr62oq5jiM2H0fQTGWdC+2LS23L0PZnyOQcGPwxfDG10l5YqKNE
         msrA==
X-Gm-Message-State: AOAM533SgOYpp8QgaLw1gnHIQ3wp6vQmMotydgUfqEm1w5BcIRAOQKKS
        gLKW/98kB5r6le9LmRrfSKjj+A==
X-Google-Smtp-Source: ABdhPJyJamPcL7e2s/JzuGoz3miJNoco1uOXZwBGQ/I6L6nREiyJ+HYGq/zKtoxN3QQCrGMXzr6liQ==
X-Received: by 2002:a63:b06:: with SMTP id 6mr45448256pgl.116.1594164984028;
        Tue, 07 Jul 2020 16:36:24 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w20sm23173633pfn.44.2020.07.07.16.36.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 16:36:23 -0700 (PDT)
Date:   Tue, 7 Jul 2020 16:36:21 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Scott Branden <scott.branden@broadcom.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Wolfram Sang <wsa@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Brown <david.brown@linaro.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>, bjorn.andersson@linaro.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Mimi Zohar <zohar@linux.ibm.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Olof Johansson <olof@lixom.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Colin Ian King <colin.king@canonical.com>,
        Takashi Iwai <tiwai@suse.de>, linux-kselftest@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v10 9/9] ima: add FIRMWARE_PARTIAL_READ support
Message-ID: <202007071456.50FD0054E@keescook>
References: <20200706232309.12010-1-scott.branden@broadcom.com>
 <20200706232309.12010-10-scott.branden@broadcom.com>
 <202007061950.F6B3D9E6A@keescook>
 <df45cc5b-62d7-21c7-a852-1433a45b68ef@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <df45cc5b-62d7-21c7-a852-1433a45b68ef@broadcom.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 07, 2020 at 10:13:42AM -0700, Scott Branden wrote:
> You and others are certainly more experts in the filesystem and security
> infrastructure of the kernel.
> What I am trying to accomplish is a simple operation:
> request part of a file into a buffer rather than the whole file.
> If someone could add such support I would be more than happy to use it.

Sure, and I totally understand that, but as it happens, no one has stepped
up with spare time to do that work. Since you're the person with the need
for the API, it falls to you to do it. And I understand what feature creep
feels like (I needed to fix one design problem[1] with timers, and I spent
months sending hundreds of patches). Some times you get lucky and it's
easy, and sometimes you end up touching something that needs a LOT of work
to refactor before you can make your desired change work well with the
rest of the kernel and be maintainable by other people into the future.

Quick tangent: I can't find in the many many threads where you explain
how large these firmware images are and why existing kernel memory
allocations are insufficient to load them. How large are these[2] files?

/lib/firmware/vk-boot1-bcm958401m2.ecdsa.bin
/lib/firmware/vk-boot2-bcm958401m2_a72.ecdsa.bin

For me, the requirements for partial read support are these things,
which are the characteristics of the existing API:

- the LSM must be able to validate the entire file contents before
  any data is available to any reader. (Which was pointed out back in
  August 2019[3].) And "any" reader includes having a DMA window open
  on the memory range used for reading the contents (which was pointed
  out at by Mimi[4] but went unanswered and remains broken still in this
  v10, but I will comment separately on that.)

- the integrity of the file contents must be maintained between
  validation and delivery (currently this is handled internally via
  disallow_writes()).

> This has now bubbled into many other designs issues in the existing
> codebase.

Correct -- this is one of the many difficulties of contributing to a
large and complex code base with many maintainers. There can be a lot
of requirements for the code that have nothing to do with seemingly more
narrow areas of endeavour.

> I will need more details on your comments - see below.
> 
> On 2020-07-06 8:08 p.m., Kees Cook wrote:
> > On Mon, Jul 06, 2020 at 04:23:09PM -0700, Scott Branden wrote:
> > > Add FIRMWARE_PARTIAL_READ support for integrity
> > > measurement on partial reads of firmware files.
> > Hi,
> > 
> > Several versions ago I'd suggested that the LSM infrastructure handle
> > the "full read" semantics so that individual LSMs don't need to each
> > duplicate the same efforts. As it happens, only IMA is impacted (SELinux
> > ignores everything except modules, and LoadPin only cares about origin
> > not contents).
> 
> Does your patch series "Fix misused kernel_read_file() enums" handle this
> because this suggestion is outside the scope of my change?

My proposed patch series cleans up a number of mistakes that were made
to the kernel_read_file() API, and helps clarify my point about the
enums being used for *what*, and not *how* or *where*, which needs to
be fixed in this series and shouldn't be a big deal (I will reply to
individual patches).

> > Next is the problem that enum kernel_read_file_id is an object
> > TYPE enum, not a HOW enum. (And it seems I missed the addition of
> > READING_FIRMWARE_PREALLOC_BUFFER, which may share a similar problem.)
> > That it's a partial read doesn't change _what_ you're reading: that's an
> > internal API detail. What happens when I attempt to do a partial read of
> > a kexec image?
> 
> It does not appear there is any user of partial reads of kexec images?
> I have been informed by Greg K-H to not add apis that are not used so such
> support doesn't make sense to add at this time.

But you are proposing a generic API enhancement that any other user in
the kernel may end up using. Just because the bcm-vk driver is the only
user now, and IMA is the only LSM performing content analysis, it
doesn't mean that there won't be another driver added later, nor another
LSM. In fact, the new BPF LSM means that anything exposed by LSM hooks
is now available for analysis.

> >   I'll use kernel_pread_file() and pass READING_KEXEC_IMAGE,
> > but the LSMs will have no idea it's a partial read.
> The addition I am adding is for request_partial_firmware_into_buf.
> In order to do so it adds internal support for partial reads of firmware
> files,
> not kexec image.

Yes, but you're changing kernel_read_file() APIs to do it. There are
plenty of users of that API. Maybe they would like to also use partial
reads?

$ git grep kernel_read_file | wc -l
77

> The above seems outside the scope of my patch?

Unfortunately, it is not. Part of your responsibility as a kernel
developer making API changes/additions is that those changes need to
interact correctly with the rest of the kernel (and be maintainable).

> > Finally, what keeps the contents of the file from changing between the
> > first call (which IMA will read the entire file for) and the next reads
> > which will bypass IMA?
> 
> The request is for a partial read.  IMA ensures the whole file integrity
> even though I only do a partial read.
> The next partial read will re-read and check integrity of file.

So, while terribly inefficient, I guess this approach is tenable. It
means that each partial read will trigger a full read for LSMs that care
about the hook.

So, to that end, I wonder why IMA doesn't do this for all file types?

It also means that we won't have a strict pairing of
security_kernel_read_file() to security_kernel_post_read_file() in the
LSMs, but it seems that only IMA currently explicitly cares about this
(or maybe not at all).

I'm not entirely happy about using this design, but it does appear
sufficient.

> >   I'd suggested that the open file must have writes
> > disabled on it (as execve() does).
> The file will be reopened and integrity checked on the next partial read (if
> there is one).
> So I don't think there is any change to be made here.
> If writes aren't already disabled for a whole file read then that is
> something that needs to be fixed in the existing code.

My suggestion quoted here was operating on the idea that whole-file
verification wasn't happening on every partial read, so this isn't a
problem in that case.

> > 
> > So, please redesign this:
> > - do not add an enum
> I used existing infrastructure provided by Mimi but now looks like it will
> have to fit with your patches from yesterday.

Right, this won't be hard. I will send a v2 of my patches to clarify the
purpose of the 3 file content hooks (load_data, read_file,
post_read_file), which might need renaming...

> > - make the file unwritable for the life of having the handle open
> It's no different than a full file read so no change to be made here.

Correct.

> > - make the "full read" happen as part of the first partial read so the
> >    LSMs don't have to reimplement everything
> Each partial read is an individual operation so I think a "full read" is
> performed every time
> if your security IMA is enabled.  If someone wants to add a file lock and
> then partial reads in the kernel
> then that would be different than what is needed by the kernel driver.

So, given that Mimi is (I think?) satisfied with your approach here, I
can't realistically complain. I still don't like the idea of each LSM
needing to perform it's full read loop for the contents, but so be it:
IMA will have the code, SELinux doesn't care (yet), and LoadPin doesn't
care about contents.

-Kees

[1] https://lore.kernel.org/lkml/20170808003345.GA107289@beast/
    git log --oneline --grep 'Convert timer' --author "Kees Cook" | wc -l
    271
[2] https://lore.kernel.org/lkml/824407ae-8ab8-0fe3-bd72-270fce960ac5@broadcom.com/
[3] https://lore.kernel.org/lkml/s5hsgpsqd49.wl-tiwai@suse.de/
[4] https://lore.kernel.org/lkml/1591622862.4638.74.camel@linux.ibm.com/

-- 
Kees Cook
