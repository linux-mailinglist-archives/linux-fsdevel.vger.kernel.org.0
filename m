Return-Path: <linux-fsdevel+bounces-40543-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5851BA24C5C
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Feb 2025 01:59:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0A4C3A5BFA
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Feb 2025 00:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20DAF1F19A;
	Sun,  2 Feb 2025 00:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="V5PlLLgZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED2029A0
	for <linux-fsdevel@vger.kernel.org>; Sun,  2 Feb 2025 00:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738457930; cv=none; b=CB0IZIsVjx+kJ7yrqfTOYUOJUHiOdBALlW5k7OPzkdakqdO5Zc9pyusc9Vm7IGvHE02i0/DKsRZr6wONhAMk4wTsLYE5bFOf3QxE/dFjqsMJGSXabbQ3A3bQzqDk8cbtOwSwz+6Fbk5nEPBRfi8Cmpw+oDeH/id5InrZa/pDcXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738457930; c=relaxed/simple;
	bh=wTdxQSHNowLLmMobvaMcMprIsVZ+/hyqVnL+ii8pks8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AV8+tvcADnLduyi7LVpMbpavh+2oxQHnl2dJ6IQ3tcQjDLZwcPYJbA81hWlpu49vZiUps/9vtuK/Emx7T0xBq/ssPRp1c3tSSMApwUFh2gWUGycloxHRjHVTbAZuVFOnSlHP/W+wzgdQ3FaqYa09rlWWdwRRaFr/3h3UjFS8OJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=V5PlLLgZ; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5d7e3f1fc01so6631880a12.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 01 Feb 2025 16:58:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1738457927; x=1739062727; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0i2RBA9AG5RGJ2Y4fhUq4YhT8DGp5O3OFexnsh+308w=;
        b=V5PlLLgZfRGdZwyQfPP2FhJGPXWXI03YFbVLrelQ5AcpbuK0nie5ZC0GgipYOGKbFy
         WPt+qu3rtT8cLPv/CdPLrOjPvH5Xn1+CGR3c1WmIfM90NUbG2EWzZtsx+jDb3heIoVzG
         tfd/n2QNTGk1wQw1rzQR1x30X2u04zRab2gXQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738457927; x=1739062727;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0i2RBA9AG5RGJ2Y4fhUq4YhT8DGp5O3OFexnsh+308w=;
        b=LS+uLf3mgEET1cKgdOrnrUsLrjVfllG2LhG8Jg82IBrMILA68cdmYSiV2SGcutbpAU
         5boCgR0GJesHHegbElmkfKF1E+6btIbnYlSA3DOcmSKBnGB9hxMgvhReBgFtAkb23eZu
         p/zQpgqv2z3sdShKjO4/G1bYOu9q8nnSVn9UfHveGW/1E5Uv7/MEAeoQPY0i7o+ZZJrO
         oOFAXJF/4OBWVGw2iYUPyPbQaLvdw3ifKJwlikQUkp97DCaYgzNfP4Wj7lhIDJy+4aGA
         oWMIT6uQwo3k4qzy0QEA8D+C8zapT35PE9pJy2znhXzAlyFSY0X5Dslq8fRtpQq5OmMK
         gTuw==
X-Forwarded-Encrypted: i=1; AJvYcCW48bJQmkUli0ADA4P67INrA6XEUzPHlnWUzQrzln4rKsixVkcVozCGdh2+vROTeTcIrckA44ITVCcvIMTD@vger.kernel.org
X-Gm-Message-State: AOJu0YykfSDEiBc1avXN/pTPqKsKEb53EvQ8dva4tykdD53B897kwnyC
	SoL9NgUfYOKtDMnwuL2P27dO3lyuKnIt8M2EMBVFerqWmefU0DP4+cINEt5gOa3Bwn1HVetMK1n
	FwYhEnw==
X-Gm-Gg: ASbGncuxFcI+2j3scnb3qdjPqP+XvTxE+tMM18PzeIAMtJucbrqI+nj+WMfAdrqFEqz
	jCbXmaLiCMyS3LTloFLQNSz7gT6S6CwiO2cmWbAf+sivp1q/DtLood1ncvfQzcEIlfg0W4u8h1w
	B1fIlODisY+hwfrwuO5rdLWwdTb+HhpW/OQirWS/rVPpiQxZv3FtyZlQjNuvStq2WzAjTVXue4d
	6AqKFAR/RY0Xk58Mw3jo2ZATORdvjH+vVyxAzmBXmnIlI3O/2EzUBIiXA7I6+1miY8kU5fNqPsf
	QueUAgarEW+C1FeA88OpGKIhLUGMegT4QAXo1Cyum9CTW4vnnnkYJSviKsPV3CVtDA==
X-Google-Smtp-Source: AGHT+IG8/2afrNNdImIykxNXZk+Sx/1UsxfeCYpcTbTyixgMjY3rYDdkO4IWSahiZl0kqsI6LTINZA==
X-Received: by 2002:a05:6402:50ca:b0:5d9:a55:42ef with SMTP id 4fb4d7f45d1cf-5dc5efc4586mr20023377a12.17.1738457926705;
        Sat, 01 Feb 2025 16:58:46 -0800 (PST)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dc724c942esm5082026a12.69.2025.02.01.16.58.43
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Feb 2025 16:58:44 -0800 (PST)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5dc89df7eccso2465392a12.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 01 Feb 2025 16:58:43 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVm1HfpI+CwybSIRLNzR7r/gTtbMRDp4bbec5WlA/SVFP7jUHbLp5hziRhJfuvQJ0eopYfeSVzT+hEVzmKy@vger.kernel.org
X-Received: by 2002:a05:6402:50ca:b0:5d9:a55:42ef with SMTP id
 4fb4d7f45d1cf-5dc5efc4586mr20023222a12.17.1738457922880; Sat, 01 Feb 2025
 16:58:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1731684329.git.josef@toxicpanda.com> <9035b82cff08a3801cef3d06bbf2778b2e5a4dba.1731684329.git.josef@toxicpanda.com>
 <20250131121703.1e4d00a7.alex.williamson@redhat.com> <CAHk-=wjMPZ7htPTzxtF52-ZPShfFOQ4R-pHVxLO+pfOW5avC4Q@mail.gmail.com>
 <Z512mt1hmX5Jg7iH@x1.local> <20250201-legehennen-klopfen-2ab140dc0422@brauner>
In-Reply-To: <20250201-legehennen-klopfen-2ab140dc0422@brauner>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 1 Feb 2025 16:58:26 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi2pThSVY=zhO=ZKxViBj5QCRX-=AS2+rVknQgJnHXDFg@mail.gmail.com>
X-Gm-Features: AWEUYZkrc1rbpsukghJrnBMXjfiiupnnm33djYsyEN114ENNjNC4tG_tthCj53k
Message-ID: <CAHk-=wi2pThSVY=zhO=ZKxViBj5QCRX-=AS2+rVknQgJnHXDFg@mail.gmail.com>
Subject: Re: [REGRESSION] Re: [PATCH v8 15/19] mm: don't allow huge faults for
 files with pre content watches
To: Christian Brauner <brauner@kernel.org>
Cc: Peter Xu <peterx@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, 
	Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com, linux-fsdevel@vger.kernel.org, 
	jack@suse.cz, amir73il@gmail.com, viro@zeniv.linux.org.uk, 
	linux-xfs@vger.kernel.org, linux-btrfs@vger.kernel.org, linux-mm@kvack.org, 
	linux-ext4@vger.kernel.org, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sat, 1 Feb 2025 at 06:38, Christian Brauner <brauner@kernel.org> wrote:
>
> Ok, but those "device fds" aren't really device fds in the sense that
> they are character fds. They are regular files afaict from:
>
> vfio_device_open_file(struct vfio_device *device)
>
> (Well, it's actually worse as anon_inode_getfile() files don't have any
> mode at all but that's beside the point.)?
>
> In any case, I think you're right that such files would (accidently?)
> qualify for content watches afaict. So at least that should probably get
> FMODE_NONOTIFY.

Hmm. Can we just make all anon_inodes do that? I don't think you can
sanely have pre-content watches on anon-inodes, since you can't really
have access to them to _set_ the content watch from outside anyway..

In fact, maybe do it in alloc_file_pseudo()?

Amir / Josef?

              Linus

