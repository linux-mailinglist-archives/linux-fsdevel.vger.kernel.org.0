Return-Path: <linux-fsdevel+bounces-38415-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63A79A021BA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jan 2025 10:24:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93A327A1751
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jan 2025 09:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 906D91D90CD;
	Mon,  6 Jan 2025 09:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="fWfmZOKq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83CA8EEB2
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Jan 2025 09:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736155465; cv=none; b=VgXUunSJsJAsaKTRvrVNZ4NCaT8UU2rW3nyNA+h6fwYoZF2VhGPWqqC0a+35rE3y0QrspTTQVlbjgnQzjCR/OUU/0oGvcmRUSAxLEoVjzO6xPhMcRuC2iaovxTRTTVFG4ApW6a2a0anMt9vLeL/6xIQw4uF2n6w5nptJGXfCOOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736155465; c=relaxed/simple;
	bh=jNO9i89qSQSBkB69s7RgnVMmgO9CzUVgQ56e8cAbncM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rah7ds5mX68i91MKgxOKqKcLwRUw/nWJQKJnPnzw7i863E3672lned8/4aHglSzumHwLEkcMeTU0C8/cnx9VjhS6wV1w1ImNCk4gdV/fhYXwbbIuKJFcD8KglEK1bpvGIUHYTCQHhvT8o0L8jGj0fAuzY8Efo/YTGqH6pLONRfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=fWfmZOKq; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4678afeb133so128357991cf.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Jan 2025 01:24:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1736155462; x=1736760262; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jNO9i89qSQSBkB69s7RgnVMmgO9CzUVgQ56e8cAbncM=;
        b=fWfmZOKqOlMW7H6/hx+j+rUuVRHfVc9lB6P459WyUgTh/24J1qHR3596q52QAmJ4JO
         Lsjy65nofJ4O7+H5Qh+5i4n4Sm26cHEDZ5nbikZveWSWBfrB9D7/Zlp1sezGm5ymXS4f
         9sLuRRhWCSyTuNkxb/2MUt7/ImTnwXE/ynYU4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736155462; x=1736760262;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jNO9i89qSQSBkB69s7RgnVMmgO9CzUVgQ56e8cAbncM=;
        b=KvaPv8P+wPsyfkyAErSNhO6tNFP9MTS3A5f8j9vc78iGOoYGRiRtmgmgd+tnYBcdj5
         6MRUmOzJILDnOUZn1xSF4Ozz8qPTyqCk5GjUtvELZ7wzKUxy/k81GTgGu0ASahFN5mty
         Ly9+TsTb1rWWbzbTysaINgVfiQANjYrKjNqSDlCpTNrZ3IFkRz+bkqim+uAt7I2umqCx
         oQjObDZYJ8QOPxRHxqRt2MSJwvS0PACP9eitOS9WrYWJtdI04ThPv9NVchXYUfbnL96u
         jFTJGogoThf4kFKECuzx5OiaAOzdb9z+yyqEfpBp5SdfRBaF0jB9jkMiPSOBP4xKf4z1
         ZpUg==
X-Gm-Message-State: AOJu0YwnO1/uKPXPJxqtClQo+BgYmhwcjJg6fdVdfqhBsx7lyRu0lnt9
	6Om+P86tWEY01OYUKZUmkP13nlm0yNpDVOMvDSUvGSqIlIfOWnmye+CIc8lsqrah1akEbN/eAw7
	6oi4pXZSI00qk/8Ygua5ZRJuehKaJ+ECm2ViabA==
X-Gm-Gg: ASbGncuvMd29HttZTG1qb3G6HZotRqlHk1E4wqYPbRIXCEHVh7IyTqm0pEtl/bxkn3X
	WLuANZLJpvfXC6ok0V2+IFlCSgO3251Exh7Qnrw==
X-Google-Smtp-Source: AGHT+IHWrslzdiFvliWwB0WkD+89NHGSCEypEDjO2vDiK7khiC9C6MRSkviDYuEL9HO/IO2YcCzIAjKaRBcbNKXahWo=
X-Received: by 2002:a05:622a:2cf:b0:467:6585:66bd with SMTP id
 d75a77b69052e-46a4b113607mr917500381cf.11.1736155462528; Mon, 06 Jan 2025
 01:24:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <677b2eab.050a0220.3b53b0.0062.GAE@google.com>
In-Reply-To: <677b2eab.050a0220.3b53b0.0062.GAE@google.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 6 Jan 2025 10:24:11 +0100
Message-ID: <CAJfpegv2hgjB9xvxFY0+wN2P74kZSN9_w_mffdv=e6Vib1atJQ@mail.gmail.com>
Subject: Re: [syzbot] [fuse?] KASAN: out-of-bounds Read in proc_pid_stack
To: syzbot <syzbot+2886d86a850adcd36196@syzkaller.appspotmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git
7a4f5418

