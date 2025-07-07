Return-Path: <linux-fsdevel+bounces-54092-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C446AFB2DE
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 14:05:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92FD43AE8EF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 12:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57AEE29AB10;
	Mon,  7 Jul 2025 12:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GUuTeRz/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4453525F998
	for <linux-fsdevel@vger.kernel.org>; Mon,  7 Jul 2025 12:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751889918; cv=none; b=PERpXeTCPNpVtF/DicySkY3LAW7lTNrwV14QqBHVZStMO5N8ysk41STdYqnkuZnEhOA6QjvLXFUHP2SUBXUQDfMUS+YjwmpsgS3izrxHQNXImHayCwL6MzKcYzVhkcaOjhhBD0ciMKV03ArA4urJ8eCbUuhaDvh92cLtuV3kIuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751889918; c=relaxed/simple;
	bh=yShfZ6ILsOBhd6koGDWWiQzQZWiggGZJjghyucsosDw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I6NG7VOKZTrTRdqFpA9mgzjBN7eUfn82J0eE2cfwPNi6cKvyEcCFfDGk0Z3TzrvoXbTdLQoYVq2NkG8T/+LbGESFbFWZlIicft5KajAcnBOCMjLdHlMdAw70i1ebv/paYb6gbyvQbnbotBd/4hX5qdU6HVJwlaYjlpga70KbNuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GUuTeRz/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751889916;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2coxbyxFXdSQKENSeYoc+GW9sQUhtsiwwJEzAsI5vW4=;
	b=GUuTeRz/1jL60rqYhhwFuCF3D8ZgG0DR0ORAgKlB6BHDyYn2EAq/CrVF/ro22+Wg9rDp0x
	OftMwoOFpRg+AVDThCbZReh2GKWsjZ8yNBdsVLOr1W4sRhOKB9PbQkd+kvj7ywBEL+2Eak
	YmbSY70crQZigGsQDvZ/eP/q+OSEuQw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-549-lDOZsrLDP42PmYw39OAS4g-1; Mon, 07 Jul 2025 08:05:13 -0400
X-MC-Unique: lDOZsrLDP42PmYw39OAS4g-1
X-Mimecast-MFC-AGG-ID: lDOZsrLDP42PmYw39OAS4g_1751889912
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a5281ba3a4so1221098f8f.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Jul 2025 05:05:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751889912; x=1752494712;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2coxbyxFXdSQKENSeYoc+GW9sQUhtsiwwJEzAsI5vW4=;
        b=I7G4g3t1uhtYOIppAtFHyl0Cmg8niJSAhhakIsL5pmbt2TKD3buXpdUVUKlhYV90aE
         8HU3yk0OjTqqZV1Mhwv5u5kjk4tOfQYM6G5PKmDtEhhSJWwVonlCnk86btz7FcR9DPLR
         Na8tITiO7RLnATvTVWOp71935qcJ3fTY76TlujUwZ8uRA+QSVPuMWhIwkej5gFSaUQ5B
         aRlxXp5t/aDtzhfG6NfC+Tk/YEmKojbH8e80fZOiN0y2GDKHnuZknLYtOlJjMlPihtzP
         mIyexauPuH4JVqWtzTta7SqEQ0jmviMepz/qs4zWH3N0+r7C54FW1zflMjb+765n/Tja
         cp/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXFR9KJ2VNdqlyy+Q7QCOqG6b5toGKGrQJx317mIPGm3Fn9vTaglkB2xLudV+HgYSri8lIB4OmAM4CR+85W@vger.kernel.org
X-Gm-Message-State: AOJu0YymttYUWsSXcUc6uhnGUlKMCmgeohOlpqgSCzgwMe0SMCy341qj
	C5h8MKevITMMS7A2/utHq/re75Z5w9LdlZnqxtDOoeOjQmBVWMctCwDzv+knNIXVskqQoI+wBUB
	C36vlVYQ36E6X1TQQ922gt9iH9vhtGxlXQkKOIq28miJcst4Wv7iE+CX/ugIgAA3LxQ==
X-Gm-Gg: ASbGncupEMYsipTEAODVUIU0XTOQW/re5crrHUy4y/WhlzReIOdf8o5D75NXriwfiD6
	f3rKI9Se8bz2rTooeXmYSPiWCTri66yyE+4r16rVXk30OncHwxKVvQXoXdOrXORAk9r64zqGRs7
	wjjzMkWJ4kYCFxzcAlnV99Oc8s8NhFxzwIXHeNjeVxrQs+TTmbf6vNABRv8fbqR/NFfFmlu4Fj7
	XQC/KDaTcMfdNo7PLJjBjEJoNyP3fSDbh+/t1y5MZ9CUkmayqRaX7kABC78rZaewfl0j8nx9rkx
	KJJ3dqhzMIA6emwE9HtfCsecRrC1yNSr+tCAheJqJA==
X-Received: by 2002:adf:e18c:0:b0:3a4:d274:1d9b with SMTP id ffacd0b85a97d-3b49aa306c7mr7357365f8f.25.1751889912208;
        Mon, 07 Jul 2025 05:05:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGEi5xHzfaruNNWM5Xa5nbbHvwTT5Ypm3IkOF4wO8OCiHtSnJRFyxUTJ6ZrNFQU7wWPBnE0rg==
X-Received: by 2002:adf:e18c:0:b0:3a4:d274:1d9b with SMTP id ffacd0b85a97d-3b49aa306c7mr7357295f8f.25.1751889911645;
        Mon, 07 Jul 2025 05:05:11 -0700 (PDT)
Received: from thinky (ip-217-030-074-039.aim-net.cz. [217.30.74.39])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b4708d0959sm9902891f8f.27.2025.07.07.05.05.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 05:05:11 -0700 (PDT)
Date: Mon, 7 Jul 2025 14:05:10 +0200
From: Andrey Albershteyn <aalbersh@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Amir Goldstein <amir73il@gmail.com>, Arnd Bergmann <arnd@arndb.de>, 
	Casey Schaufler <casey@schaufler-ca.com>, Jan Kara <jack@suse.cz>, 
	Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>, Paul Moore <paul@paul-moore.com>, linux-api@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, 
	selinux@vger.kernel.org, Andrey Albershteyn <aalbersh@kernel.org>
Subject: Re: [PATCH v6 0/6] fs: introduce file_getattr and file_setattr
 syscalls
Message-ID: <uzx3pdg2hz44n7qej5rlxejdmb25jny6tbv43as7dos4dit5nv@fyyvminolae6>
References: <20250630-xattrat-syscall-v6-0-c4e3bc35227b@kernel.org>
 <20250701-quittung-garnieren-ceaf58dcb762@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250701-quittung-garnieren-ceaf58dcb762@brauner>

On 2025-07-01 14:29:42, Christian Brauner wrote:
> On Mon, Jun 30, 2025 at 06:20:10PM +0200, Andrey Albershteyn wrote:
> > This patchset introduced two new syscalls file_getattr() and
> > file_setattr(). These syscalls are similar to FS_IOC_FSSETXATTR ioctl()
> > except they use *at() semantics. Therefore, there's no need to open the
> > file to get a fd.
> > 
> > These syscalls allow userspace to set filesystem inode attributes on
> > special files. One of the usage examples is XFS quota projects.
> > 
> > XFS has project quotas which could be attached to a directory. All
> > new inodes in these directories inherit project ID set on parent
> > directory.
> > 
> > The project is created from userspace by opening and calling
> > FS_IOC_FSSETXATTR on each inode. This is not possible for special
> > files such as FIFO, SOCK, BLK etc. Therefore, some inodes are left
> > with empty project ID. Those inodes then are not shown in the quota
> > accounting but still exist in the directory. This is not critical but in
> > the case when special files are created in the directory with already
> > existing project quota, these new inodes inherit extended attributes.
> > This creates a mix of special files with and without attributes.
> > Moreover, special files with attributes don't have a possibility to
> > become clear or change the attributes. This, in turn, prevents userspace
> > from re-creating quota project on these existing files.
> 
> Only small nits I'm going to comment on that I can fix myself.
> Otherwise looks great.
> 

Hi Christian,

Let me know if you would like a new revision with all the comments
included (and your patch on file_kattr rename) or you good with
applying them while commit

-- 
- Andrey


