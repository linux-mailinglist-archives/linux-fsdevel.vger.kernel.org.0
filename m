Return-Path: <linux-fsdevel+bounces-53652-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E43A8AF59D6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 15:44:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 273BA17AD05
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 13:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 000C72609EC;
	Wed,  2 Jul 2025 13:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mke0nmCj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA78D210FB;
	Wed,  2 Jul 2025 13:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751463823; cv=none; b=JkHJ7UoCEBs/271fGK1sJ6l8bM1vSSF9D4gilD2Yyi1s1VWZlPIDf6apku5xh/4D/IIsBo1FmyH2AZOrmdOAfg03dTQ0JQjDEtCCW4PCnrlEGcfWXiIBtXa/yQrr4FNsjsgnjBrdpd1HV1og0odA8DT/VXsepdzX/o1Ly05HIF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751463823; c=relaxed/simple;
	bh=1sxzDC5zf3UuhHKDufGOR1abNbNpZjrzvWoD6tTHOSg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o1Ffhdh+yPWGfI2nmzYABBBfhuPte52Df9phVO5yRpp33zJgiW/knhfhk1fAp1qRKvhpa6qNTvHs+kruQMpI07AINrFQAVoEbMYkmJlpAts/R+fyhM8499kMVGo7kXDhN9nWjg9sr7Mpzmccj1Dm374Qhuqsb0JpOwy80bJVAlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mke0nmCj; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ae360b6249fso895828766b.1;
        Wed, 02 Jul 2025 06:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751463820; x=1752068620; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UwIDCZCusW6djd9Ye3kiK32Dnzf8SQVyvqtNWdIs4aA=;
        b=mke0nmCjT67d3SNVWwFFFCFv9qH2cwkheJ5n9PLjnOkMqaP7GCJpqvuRbH1qipyzM5
         3s57ro02sfj0ohRhXHfy6zo+RFzVRxXpNAP7imEtw6yXrZ842vpFYM+sLWSxNWsrqLma
         GKOmhcqG2x9b8vmSWdomyqAEt4/h50KkyjCrstf6t/d0jdIS+BqIjslFEuSCLS9OZXOD
         3od2hvu5JOxVu4r7drmnayUju58WjVFae1B4f6VR70t0c677wu3pXzgyRnS7bSAl2mqy
         x3G3NUWp8cjNC5jsOX4bxd6yEd+L8KyOwekEuXBqmH5FOASmQPlSBZt3XQMtgZkfXOC0
         mqCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751463820; x=1752068620;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UwIDCZCusW6djd9Ye3kiK32Dnzf8SQVyvqtNWdIs4aA=;
        b=o4x8QErHvBfRvSvGdzI/mSYk1NB/kDbRqUcQrOO8BZeyBAgAaJygsW603mGs7W7jdP
         bpyQCRRTg5tf2tzGe/iEyu2SB73yJEd75ZGS6HrjUsHA7JdJSx3UOT9Lud6mkLe/pq3h
         rBmf9j2PiT+IehuaYk4fi7OfzV2RUFKLd61i5wVhwCpYRhuytENBZdRfETfGYDkiXmdo
         0K3Geydh6tpLBu8v0dBsy/2JqQRzVasYFH1upZfEApNaprjRd9gd1R7KHQJOnRadT51F
         3uOuO0QqkYE9fBWRsAaz2ihtjkPktPV+WtiMFUJnbireTYqgEFSOG3gDXQcLX+nyhK5h
         QNoQ==
X-Forwarded-Encrypted: i=1; AJvYcCVzAhtAAXXS8+XKnbNlztPFihB48vVwTHqPx1LMVzcMX3dlj+CCY/C581embZFz69RqG6gN/Rv75fzHfMFV7Q==@vger.kernel.org, AJvYcCW2dlUy73DnHfsPasdQ33rFCCE7UWpq8s9xAfZ+yh+E+v64OiiUq9Ng1YPKfKxiyAmw12JTM36gXuLVG9d5@vger.kernel.org, AJvYcCX+6QnJ8jqYUvLHPdfnOq+7QayqVkuQboYYegPZGAEkz7tnqW8k8FDhJd+J44zw/ztAoPySduXZVA==@vger.kernel.org, AJvYcCXCxcaX3/icHivWXcf1x0qIzgDi5nDcHIfwlOgCvJvaEjrY15B6Twzm2AbUS93VuFE+FecnBXD8RX8=@vger.kernel.org, AJvYcCXky29fUalaaEnj7n7nkQXBnutH245fOm2TDAKO0fbFp2qTsUdE+kjnyC2w4erSPxHPXH5DXSj0CzdQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5lv6YQmTqNSd3Z1VguwxnXOtng2YUz+95z7taR7Bh96W89LLU
	NWr/ZeDIxU+mJfwjH47RxOcQLlOrLcRmZ5Dr+Zl+59S3pbOEQrOJeRMw0RkrSg4/I963RDnVx9/
	Bf4MNFHW8S42NlKdzQKqO2xrbWa6N9G8=
X-Gm-Gg: ASbGncsHjsX8einJNq5rxCjzuBfFNfqNy462ToNP1iclW8ZAmTvWyDuJfhICuVZqxCx
	0amc3vnwJZF5bz2ZRmUGXv9+h9NvNIGfetcCnJlqC/pR0qdlbM/RXV5lULSKZhpqjrcGr0Yegb0
	fSmzD2sutmqU95jATonzV/04iLrqRg3xmygJY7LUINIuZzD9Km7eGYRA==
X-Google-Smtp-Source: AGHT+IEJPX6UR9g84WoexbzzHUEQq6h3wPdSNSsyqViJdHMEb+94B4bmHAHCPHuJ0zmK7ftG43fN0Hd7MLLMLWsWtBg=
X-Received: by 2002:a17:906:6a09:b0:ae3:8c9b:bd64 with SMTP id
 a640c23a62f3a-ae3c2ce7628mr342266566b.29.1751463819440; Wed, 02 Jul 2025
 06:43:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250630-xattrat-syscall-v6-0-c4e3bc35227b@kernel.org>
 <20250630-xattrat-syscall-v6-6-c4e3bc35227b@kernel.org> <20250701184317.GQ10009@frogsfrogsfrogs>
 <20250702-stagnation-dackel-294bb4cd9f3d@brauner>
In-Reply-To: <20250702-stagnation-dackel-294bb4cd9f3d@brauner>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 2 Jul 2025 15:43:28 +0200
X-Gm-Features: Ac12FXw1I6BqbNe0ftFra8l5z14QYm57oMc5TjvDPGU72Dw-9sfBMZjzC6un8jM
Message-ID: <CAOQ4uximwjYabeO=-ktMtnzMsx6KXBs=pUsgNno=_qgpQnpHCA@mail.gmail.com>
Subject: Re: [PATCH v6 6/6] fs: introduce file_getattr and file_setattr syscalls
To: Christian Brauner <brauner@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>, Andrey Albershteyn <aalbersh@redhat.com>, 
	Arnd Bergmann <arnd@arndb.de>, Casey Schaufler <casey@schaufler-ca.com>, Jan Kara <jack@suse.cz>, 
	=?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
	Paul Moore <paul@paul-moore.com>, linux-api@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-xfs@vger.kernel.org, selinux@vger.kernel.org, 
	Andrey Albershteyn <aalbersh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 2, 2025 at 2:40=E2=80=AFPM Christian Brauner <brauner@kernel.or=
g> wrote:
>
> > Er... "fsx_fileattr" is the struct that the system call uses?
> >
> > That's a little confusing considering that xfs already has a
> > xfs_fill_fsxattr function that actually fills a struct fileattr.
> > That could be renamed xfs_fill_fileattr.
> >
> > I dunno.  There's a part of me that would really rather that the
> > file_getattr and file_setattr syscalls operate on a struct file_attr.
>
> Agreed, I'm pretty sure I suggested this during an earlier review. Fits
> in line with struct mount_attr and others. Fwiw, struct fileattr (the
> kernel internal thing) should've really been struct file_kattr or struct
> kernel_file_attr. This is a common pattern now:
>
> struct mount_attr vs struct mount_kattr
>
> struct clone_args vs struct kernel_clone_kargs
>
> etc.
>file_attr

I can see the allure, but we have a long history here with fsxattr,
so I think it serves the users better to reference this history with
fsxattr64.

That, and also, avoid the churn of s/fileattr/file_kattr/
If you want to do this renaming, please do it in the same PR
because I don't like the idea of having both file_attr and fileattr
in the tree for an unknown period.

Thanks,
Amir.

