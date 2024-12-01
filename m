Return-Path: <linux-fsdevel+bounces-36194-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E8579DF4C7
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Dec 2024 05:27:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB475B22DB3
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Dec 2024 04:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BC1D4087C;
	Sun,  1 Dec 2024 04:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AxmcoWUC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B03817C68;
	Sun,  1 Dec 2024 04:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733027238; cv=none; b=TQQGXPPd0xtfTd1Ep3T6hiABo11XjGEa7Q9zND9swI/H/88CcsrVIZLlzWBwEF7fDIhorNCFpejPX+6gsPTgqg/igywwYEZAEqHNwRPHwk5D2HvAhg3VYGDHsjBm+G5tB5Mdvn8d5230ba3rd1auVRfsgVYnxZLCK4C0pT/FPlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733027238; c=relaxed/simple;
	bh=2ZogH2EPnIE680Utg5LOR3b/CcSI+aOc+JmKRGVsqow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fBsvZ/FY4Co+K8SFLLA2b55kRjzJRhguFWpAN3U4m7tz5rLqTtaLJT7Dn1pblq2/gEZLaYPlxnMyWRxVl2yVbH27+1GESrSj30tlJAq3lwXBOsXnzPkboV+ATHdewp+JdzadydboSe2PfKQ6Btn4a5IaQ/JVygiS9oYUcaaTHGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AxmcoWUC; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7fc8f0598cdso2813340a12.1;
        Sat, 30 Nov 2024 20:27:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733027237; x=1733632037; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2ZogH2EPnIE680Utg5LOR3b/CcSI+aOc+JmKRGVsqow=;
        b=AxmcoWUCf+v6wNlDwuJoR4DDZMkb9TzMf/NyZt2jFvMsQgs8gPfL8NQnGw98N/2dZw
         Vm+uBOZWbfj0gwVMuxug8qvHJrVM9uzgg2coQ61V0A8go8rYg2jz1pKcz1VqQkvSGnJX
         oWvrc2Ryn6KQ9L/9KzCgk+4H/1KaQLYdaPka2XYsBYaSDcIOrGohLw6SKHxA9OW1Z8il
         0UDuuMio0ctjZGuhcYB4v88Z9vL3bl307YW3rnyxceB7E035AhCNGvzeeUy7eIzV9MVE
         9dPZFb3A/t4fZtkz2VRJxqfQEAnUdEuRD4HBOhPciUkkfSgB7b9GUiSMaw4F18+9/LMv
         evkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733027237; x=1733632037;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2ZogH2EPnIE680Utg5LOR3b/CcSI+aOc+JmKRGVsqow=;
        b=TXhRrHZnyama5a5JNVdo2XHI7UOlVpJITy66tseIe3E0HkF76u83AVY2RCYdE24ajC
         Bxwj3Ad+vocXfzj5RbhpCxx7bdqunJ/5BPyUnSrxdRQlaw78hx3DgouaDKtTHeNOCYPe
         lB7GNEJDfI/zOCtmoAcelwY1Vw0ZQiBotKHU3Dn2RUKoS5ptpxmp7N+uulQzzBDvuWRI
         0TNUWpfVwnPbefDlYxBDjdoSv/o9YbS9WDMSiqOlQ5YOiCyi68VZBT2W+lgsQtPH8ZBe
         aPqk8d5y8eBT/rjFypf66aBC5SQIjNVFlOiR8oFfBjPZ/kOcgToQ5Znc7+2SE73kuBYj
         z5YQ==
X-Forwarded-Encrypted: i=1; AJvYcCUzthVJmihKNZ5OfnUC/vFk1ZR7auRen09fdeZLJIWX/SzyaUoRMPnEBFjnTTis+muDoGMGE0adsxGqn8L8@vger.kernel.org, AJvYcCVulKKGlmT42tafE7I20+FpSiRQUvwFVW5GRuCHRsyM/CjSItSDUnYX8oPNKASY7bdp0hf/kFp9SZzEzXom@vger.kernel.org
X-Gm-Message-State: AOJu0YxjEsnDibQii+NtC3+jy+D4M4h8cVlb2+T2k6DpMJVXWhzakqAW
	H+Z0Y9iLwj1/4c0QISyDvzye6NDVpf9auqFlUjxGtvQN16BWUvr6/BPyPObYKxQ=
X-Gm-Gg: ASbGncsr2cI2yw0UR5+tVMjlZQV3XlJYT60FtKbVSWpAjQLsjiM1SeB98MEWwCEczS6
	vGxogyEieqBjQ2FJAp5yMu5nz0p3WD/Nth9wtm33s6XUwiY6XjE4kW/LPReamW+8rOrX2SylYvz
	fE4NCKI0THZmTmwd7H0KCMh5eUP9f9hn769iccI9I5Z1lEh+zGJXwSLWNKnaBL+49vdcPN2MdFF
	PuQ4hLoTM2oNnTuEp2RhHfE8ILSzLuyegKkrOI=
X-Google-Smtp-Source: AGHT+IHV/TP3rSiKf1c6g2kaD+Zzi04s7Zfm2Zdwkx7p7gOobHmXiUjK5qu2qs4CMes4/RuVL+LEXg==
X-Received: by 2002:a05:6a20:a105:b0:1d8:c646:f51 with SMTP id adf61e73a8af0-1e0ecaeca21mr21027394637.20.1733027236672;
        Sat, 30 Nov 2024 20:27:16 -0800 (PST)
Received: from tc ([2601:1c2:c104:170:a600:8588:f159:8ed9])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fc9c2d3e7esm5516767a12.5.2024.11.30.20.27.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Nov 2024 20:27:16 -0800 (PST)
Date: Sat, 30 Nov 2024 20:27:13 -0800
From: Leo Stone <leocstone@gmail.com>
To: Jan Kara <jack@suse.cz>
Cc: syzbot+2db3c7526ba68f4ea776@syzkaller.appspotmail.com, 
	brauner@kernel.org, quic_jjohnson@quicinc.com, viro@zeniv.linux.org.uk, 
	sandeen@redhat.com, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, shuah@kernel.org, anupnewsmail@gmail.com, 
	linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH] hfs: Sanity check the root record
Message-ID: <rdkuuboofty3nqjhmde667jwowcxnuo3q3mxcjrn3ip2xh2fhg@eo7aqzad775b>
References: <67400d16.050a0220.363a1b.0132.GAE@google.com>
 <20241123194949.9243-1-leocstone@gmail.com>
 <20241126093313.2t7nu67e6cjvbe7b@quack3>
 <wzxs6mjqlpf2eszoaw2ozvocqg3lpaqx7mzog4tygxexugrbsu@3pxs2vthfagb>
 <20241126215254.aw7l7k3tgx2tawzu@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241126215254.aw7l7k3tgx2tawzu@quack3>

On Tue, Nov 26, 2024 at 10:52:54PM +0100, Jan Kara wrote:
> Yes, this strict check would make sense to me. I just don't know HFS good
> enough whether this is a safe assumption to make so it would be good to
> test with some HFS filesystem.

I tested with the System 7.5.3 install disks, as well as 2 disks I
formatted inside System 7 in an emulator. The root directory always had
entrylength of 70, and it looks like every directory has an entrylength
of 70.

I'll resend as a PATCH v2.

Thanks,
Leo

