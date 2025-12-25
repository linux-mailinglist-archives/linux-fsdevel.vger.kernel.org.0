Return-Path: <linux-fsdevel+bounces-72096-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C740CDDE1E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Dec 2025 16:18:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 13A8F3022A9A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Dec 2025 15:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D528132B99E;
	Thu, 25 Dec 2025 15:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cgCAOeS8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C7D329390
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Dec 2025 15:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766675899; cv=none; b=cp0qL/1MlnZ0USmeaTrxcYBhRwBwzSCrzN1FFPbiCQNUhDzl2IqsXe6W4CJf0uW6Qx2d6somrJbEb29FXdj7TAMpb+aCIfc0Qem+XBAaLHPn8Y6eidZw5UIpqsujnqFcmxBRWSPvMtdL16Cij69y0B74G9MfPYN+2lOAh5y6TY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766675899; c=relaxed/simple;
	bh=MbMBUpR7B2x4JyBu84ec/Nl4m/QIwV9QVVSShfb9dMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r5N7RuAwlI+EcolK6rYDXAr0akPXI8zjy1PMHnkjbdDgBSp5wqreAIay1YAXh9xsvpuuV3BGx6P8rZuZMsU2/9haO+SQqe87kRBUECM4Eg5P5mei7wVBszeIE57JoLJdM4bP5muoVBL/m8eNC1o+iRjAX95HNAk+g77lSh7XaLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cgCAOeS8; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-34ccbf37205so4904101a91.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Dec 2025 07:18:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766675897; x=1767280697; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Qs6BJX7+RWUbYyZjj+cOPleo4iCRlFe1YsbACYZyhFI=;
        b=cgCAOeS8Yvk+9LCKE/fHmRulgnlQzJIUyW0juEgc3OseKtBjGdBOSNyCXbkOC7COCt
         Is33sTVt5+DDeP3u4VMRsm2qWaBgQAjIIusab5yL91HohBt4r9wTkAw4XJMQwRktM9jw
         ukEeNSY/DqEsP50+iVRoWfWSb+1WfqlM+ogrLAar6LTqMICAjYXqsVxnNpN6EL/ljSTE
         F0pm3q7kY6+xDulaoaeEx3rrJRtFh18F3eJfqTsLGVfmhfRRep8gp5ueYU5XUHCIpvp3
         JIRn0z5/dCf3wMGoUaQlFbFsROQJNlhPpK6uILb+9ZWyevuqJSEpDVk8JU1wKmXhi06l
         xO1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766675897; x=1767280697;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qs6BJX7+RWUbYyZjj+cOPleo4iCRlFe1YsbACYZyhFI=;
        b=tyFUuyek1yjiOik/TXY5U6n1qK/mitazSkbfXrNwJxH8REjL8v1YHjKO/jAYheDla2
         Zic2gR7hi6xaRs/dOCW6q+212e9mp2glka4q5G/ijYfO1MOw6/ybjTngMnKbcuooAFf2
         6ZmSY/eKhjWqUYuK2sSmQyOu8xNl4ckrNuCGi+4CVtjbSHjhFMoTLxTOYjM8evT5wrJA
         mtY04/X1RhUSczagIui/ywSvMaihnXvfdeAu80Q6n/QDmMmRl49UCNu+fV0hzbeRrZDY
         Y0STksrRG7+9kZfxfUdbePGSdbRbH9Riqw+49ml1dFeNTu16bnngekT8hlTA1/iWyJxP
         qBXQ==
X-Forwarded-Encrypted: i=1; AJvYcCUcj6vHJKn2fAmlfr1Ot+4WiK92rLf2qZk4I8YDyVjUruPo8sid5EiMd8ia9DM+3OmQ3E+XlzUnXSI9KS5T@vger.kernel.org
X-Gm-Message-State: AOJu0YzQLziknxvKKUSAycYNve7On2yJJXGyOtq6YIZa1y+9Lmz506OF
	pA+OOM4hN43iYzK+J2RFJQTRfC5/0UjUjX5gV83Glfs5111i+zpNwN6OpqpeSmCD
X-Gm-Gg: AY/fxX7/95jjtX5c3ZhMpK9KHtUstTMscZXjmGS0pXRYuyXgs+qSx7Iy2W9ui6S1IyK
	S18QGBkRgSHxvJ7ZQZbFxG6/GAj7DaDYzfckSSrVAyAC4o+Jrsj7hUdhlcmOnjrU1jTvzo3ZAK/
	bMr3OZalgJBXsUPCwYDOKPMnYpodrQJfio8E/AmB1/mkdTFFtolmOWnMQ0z0JPqqV1KR3pPwHak
	vi/Av31/EpwL0pqakh49YwrHh6mqiBH4JuzWcyJTFMJmWv1k266avN+h6z0uKvQvDwkIUw/DUAs
	Iil0DjKaM6s4zcu96S7V4CnD5aY+ONZtyN2wlGPVcwx+s09tF6XpECe9mD0Vj0WSDe98gjmm+2W
	2WqK1SgG/zL0riNO1+lyX3068+URqnHqQwhV6of7IQyQ9pyF9H7gRZ8vw/ISAUWeEPUILCJ2MAI
	SoEyThEBBwiIc=
X-Google-Smtp-Source: AGHT+IFyYhem34TIt5JkWzwnSB53xq94ui6A4MQrPDy5SuIyfwhYp7CBOvr+9/vlj+sQXcZsrKKlUw==
X-Received: by 2002:a17:90a:c888:b0:340:be44:dd0b with SMTP id 98e67ed59e1d1-34e921f582amr15972331a91.34.1766675896814;
        Thu, 25 Dec 2025 07:18:16 -0800 (PST)
Received: from inspiron ([111.125.235.126])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34e772ac06fsm9337558a91.11.2025.12.25.07.18.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Dec 2025 07:18:16 -0800 (PST)
Date: Thu, 25 Dec 2025 20:48:08 +0530
From: Prithvi <activprithvi@gmail.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: io-uring@vger.kernel.org, brauner@kernel.org, jack@suse.cz,
	viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev,
	skhan@linuxfoundation.org, david.hunter.linux@gmail.com,
	khalid@kernel.org,
	syzbot+00e61c43eb5e4740438f@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] io_uring: fix filename leak in __io_openat_prep()
Message-ID: <20251225151808.lvpfdwqvcej4vxgm@inspiron>
References: <20251225072829.44646-1-activprithvi@gmail.com>
 <176667533028.68806.11770987520631890583.b4-ty@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <176667533028.68806.11770987520631890583.b4-ty@kernel.dk>

On Thu, Dec 25, 2025 at 08:08:50AM -0700, Jens Axboe wrote:
> 
> On Thu, 25 Dec 2025 12:58:29 +0530, Prithvi Tambewagh wrote:
> >  __io_openat_prep() allocates a struct filename using getname(). However,
> > for the condition of the file being installed in the fixed file table as
> > well as having O_CLOEXEC flag set, the function returns early. At that
> > point, the request doesn't have REQ_F_NEED_CLEANUP flag set. Due to this,
> > the memory for the newly allocated struct filename is not cleaned up,
> > causing a memory leak.
> > 
> > [...]
> 
> Applied, thanks!
> 
> [1/1] io_uring: fix filename leak in __io_openat_prep()
>       commit: b14fad555302a2104948feaff70503b64c80ac01
> 
> Best regards,
> -- 
> Jens Axboe
> 
> 
> 

Thank you!

Best Regards,
Prithvi

