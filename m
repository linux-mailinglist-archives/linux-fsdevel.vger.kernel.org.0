Return-Path: <linux-fsdevel+bounces-46268-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 360BFA86036
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Apr 2025 16:14:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D8E01890A84
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Apr 2025 14:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C1831F4CAE;
	Fri, 11 Apr 2025 14:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="izRko/IA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F1073176;
	Fri, 11 Apr 2025 14:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744380691; cv=none; b=u7FRqIMxkVXl5IZU08F5wE22yIind87dXvePBv1sXmSfJrxtROU0d5xzZ+vxqYey0dulUYJRbzaTHZMz5nrjUb0//wuEakvmqzzTgSf+31hb9027EPXdnl5lxWnkyJw1/NWrRSumH/zUx8vgf/9wQp7RenueePNLNQ8nQpckhYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744380691; c=relaxed/simple;
	bh=vaJtVVwYezJNolvJSHZ/Z1JOjsT4CKEdBHtvqBdwU30=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WmCfog8TAfMKkjJaQO0vYyvG+LN5098NGQDgXi6wUgspzHsWHl56CEddsGAREhA2o2ge4k9upBh/cT0YOdT0+ed/HeIciR3rndjvbjowJR3VCdBaL08lNM9VG9Vh5/4wozgnDkmfsgA56/rs2ma+4rzwb8lc6PjD3CNaFfLKqt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=izRko/IA; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-72bb97260ceso702615a34.1;
        Fri, 11 Apr 2025 07:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744380689; x=1744985489; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8EoyrupwTEtbZwQXlvvRXTwgUv8DtYsYUCtvWZBr1js=;
        b=izRko/IAwfHU31TwR3Tx51ICKcqDAvO0vZ9uoieJt8zm0/3KZU+QeRhejG9FS5UUgd
         D3O/byDBtVXeecOUdhEqJLhLEQ2quSRUcyLgdA4P+T4gPqEKR/SfjtkEVNB7db+BhCwI
         rgAGQR5aENssOxcgHfuEDsED7kp+RRBsvbXqs1WHJeEvZy0yyqlmN1xogxVl5oOK5lnB
         cYKZvwzfqxn9rSnOprT3ws6aIh23+vFcBLesVHW3z1nPX7CSB9FYQS4O6m2ipNrq13Gl
         3/RQXJdcicoOgr01mLBtP8sv29I/v3Vkt3TgzNb9GYY+H/vOkG7heB4QkhV/iSbaMTnh
         ESig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744380689; x=1744985489;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8EoyrupwTEtbZwQXlvvRXTwgUv8DtYsYUCtvWZBr1js=;
        b=IoU8s8phNstybhcuBD6xN6bEo1IsBZ1gkw2cAX7ZDX1eZe1jIX3rCu0j+3dJ/kKGid
         Q+RkZ7Bb8vReaC6Bx5XhShoEr1zFecZu1eIdH3iQj7jePasOlccTYt2e2SyHqGq9lAnB
         yQ0+tAVhKJuzNNpCpHuukr3YNBzl6q/StwRm/uFgiMViHA91eX8fGCYBQ24XGxZw2VlP
         BA7Awma475E2ghIL5/lt1KHrgAYgqLdEyTW3ugc+ZRVpMaOctFrrQq4WVCchQOtN/T+O
         loqOrKMz7e/u1hIv60/f/KQVCzfh7G4AyDAqjjNfCuc4kwOLDXL25USlYTD+kycQz3OG
         cC6w==
X-Forwarded-Encrypted: i=1; AJvYcCUKaM7Knq/CrRy40di07cAVNuvXgauqwkRY4FWsW8yI35ACc839SYrH+v7Ar7l1IR0haQROn4178JeMCefiCA==@vger.kernel.org, AJvYcCVH5h+XY+ramhBvDkRs7dT8OYVdJl0bmJt8NqCWHQMeLL+ZA16IkklOXmB9zLlGvoM/bN1rUZKqJws=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOvsPjQs+3kjQaC/vavDRP/0gycUUAKmGhMBW0KQyxL/KxJRSB
	K74FeusiZX4Sr02MP7l5L5x68m0o9VfOPlKj4I2mo4Jf+HHcJKpo
X-Gm-Gg: ASbGncuWqTypeStTNin0ClGXw9kugSFtUck7sUQEOnHirt6xyZqrz7UwVIYFcIUpoLu
	dTlnvAin33iJ3mR1XmQftBUufjwAUQUSyuwXyLE1sfE3ZA0idzajYtmb4Fh8p1Vtg5jkwb11vFY
	KcK5r+f7aMetAN4eGs1/4O95wBjmk60TJsNect/k7s+ptcXBihikttdj+xycgE0wykGHPEBRDNv
	h61Ht2mv/R36T8CSye+sNL4gH4NBIrnCmALuCIng+0Mh9etrorIG0P9YpOlitTvHT6Vze+Pv3XB
	PsOrcr5TV/0vc+3gIlbtZ3+1MDkvt62THaE2hBLoMwT96w554bHHlFzrA9jS
X-Google-Smtp-Source: AGHT+IFqFbmaASrYe/cW2MSIXxfRdZxjVbEapk+IVePLGdxBuY4A2iVMiWVW0k9HogsgNayf8P03/Q==
X-Received: by 2002:a05:6830:6186:b0:72a:1dfc:c981 with SMTP id 46e09a7af769-72e8653a057mr1992876a34.25.1744380688825;
        Fri, 11 Apr 2025 07:11:28 -0700 (PDT)
Received: from Borg-550.local ([2603:8080:1500:3d89:ec04:946b:bd13:7e7e])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-72e73e4db34sm946969a34.49.2025.04.11.07.11.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 07:11:28 -0700 (PDT)
Sender: John Groves <grovesaustin@gmail.com>
Date: Fri, 11 Apr 2025 09:11:26 -0500
From: John Groves <John@groves.net>
To: Miklos Szeredi <miklos@szeredi.hu>, 
	Amir Goldstein <amir73il@gmail.com>, Bernd Schubert <bernd.schubert@fastmail.fm>, 
	Stefan Hajnoczi <shajnocz@redhat.com>
Cc: Josef Bacik <josef@toxicpanda.com>, 
	Joanne Koong <joannelkoong@gmail.com>, John Groves <jgroves@micron.com>, linux-fsdevel@vger.kernel.org, 
	linux-cxl@vger.kernel.org, Aravind Ramesh <arramesh@micron.com>, 
	Ajay Joshi <ajayjoshi@micron.com>, Eishan Mirakhur <emirakhur@micron.com>
Subject: Re: famfs port to fuse - questions
Message-ID: <yt5zatqobd5wa27l6nownqheqvqxfz2wkojqlbj5jsu2uz52am@fh7uud2u4v4b>
References: <20250224152535.42380-1-john@groves.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224152535.42380-1-john@groves.net>


OK, I'm on track to post the first famfs/fuse RFC patches next week. This 
will be a kernel patch, a libfuse patch and a pointer to a compatible famfs 
user space and instructions.

Dumb question: where do I post the libfuse patchs?

Thanks,
John


