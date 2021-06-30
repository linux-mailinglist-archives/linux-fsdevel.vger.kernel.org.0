Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D6733B7EB0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Jun 2021 10:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233442AbhF3IKe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Jun 2021 04:10:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33456 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233304AbhF3IKb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Jun 2021 04:10:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625040482;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=spXMVCuw6N13xLjcZGemYJM/fS6G+xh95O5x4vR27TA=;
        b=OWR0TFQKbwRRrRFQdmmtbq6QQrvoe53uEI+PzplIStXMHP1/mnI59qEQX0SAFdX1dXoJ76
        DLqMZ0IItq4d9RNkZusg2qMIKcF+FGYWprAoYJexTl4qA15v4WA0nt4hdIMoBCXDDd06rm
        FlV+l+r8Hn7YKQdvHX/VfaJQWqeRO2U=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-89-wjrGa7ciPlyAMenaoWb-TA-1; Wed, 30 Jun 2021 04:08:00 -0400
X-MC-Unique: wjrGa7ciPlyAMenaoWb-TA-1
Received: by mail-wr1-f70.google.com with SMTP id l12-20020a5d410c0000b029012b4f055c9bso335840wrp.4
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Jun 2021 01:08:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=spXMVCuw6N13xLjcZGemYJM/fS6G+xh95O5x4vR27TA=;
        b=m/33tW7pwytcojxGuMt3bK0/uk4fekLe7UM+gQHqGTXACYPmfmo6FSrhiCVtv6gaTL
         ni4N70IcH2bVdSb26QlXwAYj0ghGVUGfy2uS9meAZSIlTj8dB2+5fb8OTRD8u8tvd8i4
         TVDO8JYz3mCCl7Ww8pamaKNA9kSQztJag0slBsDVOuYgXkc9mLH5f7Ks1k4DhUvH9Y/M
         wQ3AKXefRdo3szRb2c/Lln9ICpX6orQWRCYU8TmnzMOFqVbuXg9V7uExTHHb4vX4HHD7
         SZopc/a5boOU1vpKjeHDWf5AIweNn8sK0ekwwjP+KBF1DpPAPuxMi94AurQwVugptXhz
         Gfaw==
X-Gm-Message-State: AOAM533QeWGAO/J4mr1RtovAfQsJE1bTWJ1tWHNGB0RIhhEHgExLF9E5
        buCJH4i06SmUizEq8BD7BU4bP+0hQ7CFXBnFnekez31BkjKdmrCSyLADDeX1okS379f3cpiTd9d
        YC0hiaJZFwyq1n+YJe7vmd1JjqQ==
X-Received: by 2002:a05:600c:4f8a:: with SMTP id n10mr3045902wmq.11.1625040479418;
        Wed, 30 Jun 2021 01:07:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxhZXi0exlmVWXNW1b1HA6azTiENG2juGHvNPkDsRCdeTCmLeynlOmWabasKRpCJAXel/C2Tw==
X-Received: by 2002:a05:600c:4f8a:: with SMTP id n10mr3045884wmq.11.1625040479197;
        Wed, 30 Jun 2021 01:07:59 -0700 (PDT)
Received: from work-vm (cpc109021-salf6-2-0-cust453.10-2.cable.virginm.net. [82.29.237.198])
        by smtp.gmail.com with ESMTPSA id m7sm22064425wrv.35.2021.06.30.01.07.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jun 2021 01:07:58 -0700 (PDT)
Date:   Wed, 30 Jun 2021 09:07:56 +0100
From:   "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Daniel Walsh <dwalsh@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        "Schaufler, Casey" <casey.schaufler@intel.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "virtio-fs@redhat.com" <virtio-fs@redhat.com>,
        "berrange@redhat.com" <berrange@redhat.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        "selinux@vger.kernel.org" <selinux@vger.kernel.org>
Subject: Re: [RFC PATCH 0/1] xattr: Allow user.* xattr on symlink/special
 files if caller has CAP_SYS_RESOURCE
Message-ID: <YNwmXOqT7LgbeVPn@work-vm>
References: <5d8f033c-eba2-7a8b-f19a-1005bbb615ea@schaufler-ca.com>
 <YNn4p+Zn444Sc4V+@work-vm>
 <a13f2861-7786-09f4-99a8-f0a5216d0fb1@schaufler-ca.com>
 <YNrhQ9XfcHTtM6QA@work-vm>
 <e6f9ed0d-c101-01df-3dff-85c1b38f9714@schaufler-ca.com>
 <20210629152007.GC5231@redhat.com>
 <78663f5c-d2fd-747a-48e3-0c5fd8b40332@schaufler-ca.com>
 <20210629173530.GD5231@redhat.com>
 <f4992b3a-a939-5bc4-a5da-0ce8913bd569@redhat.com>
 <YNvvLIv16jY8mfP8@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YNvvLIv16jY8mfP8@mit.edu>
User-Agent: Mutt/2.0.7 (2021-05-04)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

* Theodore Ts'o (tytso@mit.edu) wrote:
> On Tue, Jun 29, 2021 at 04:28:24PM -0400, Daniel Walsh wrote:
> > All this conversation is great, and I look forward to a better solution, but
> > if we go back to the patch, it was to fix an issue where the kernel is
> > requiring CAP_SYS_ADMIN for writing user Xattrs on link files and other
> > special files.
> > 
> > The documented reason for this is to prevent the users from using XATTRS to
> > avoid quota.
> 
> Huh?  Where is it so documented?

man xattr(7):

       The  file permission bits of regular files and directories are
       interpreted differently from the file permission bits of special
       files and symbolic links.  For regular files and directories the
       file permission bits define ac‐ cess to the file's contents,
       while for device special files they define access to the device
       described by the special file.  The file permissions of symbolic
       links are not used in access checks. *** These differences would
       al‐ low users to consume filesystem resources in a way not
       controllable by disk quotas for group or world writable special
       files and directories.****

       ***For  this reason, user extended attributes are allowed only
       for regular files and directories ***, and access to user extended
       attributes is restricted to the owner and to users with appropriate
       capabilities for directories with the sticky bit set (see the
       chmod(1) manual page for an explanation of the sticky bit).

(***'s my addition)


Dave

>  How file systems store and account
> for space used by extended attributes is a file-system specific
> question, but presumably any way that xattr's on regular files are
> accounted could also be used for xattr's on special files.
> 
> Also, xattr's are limited to 32k, so it's not like users can evade
> _that_ much quota space, at least not without it being pretty painful.
> (Assuming that quota is even enabled, which most of the time, it
> isn't.)
> 
> 						- Ted
> 
> P.S.  I'll note that if ext4's ea_in_inode is enabled, for large
> xattr's, if you have 2 million files that all have the same 12k
> windows SID stored as an xattr, ext4 will store that xattr only once.
> Those two million files might be owned by different uids, so we made
> an explicit design choice not to worry about accounting for the quota
> for said 12k xattr value.  After all, if you can save the space and
> access cost of 2M * 12k if each file had to store its own copy of that
> xattr, perhaps not including it in the quota calculation isn't that
> bad.  :-)
> 
> We also don't account for the disk space used by symbolic links (since
> sometimes they can be stored in the inode as fast symlinks, and
> sometimes they might consume a data block).  But again, that's a file
> system specific implementation question.
> 
-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

