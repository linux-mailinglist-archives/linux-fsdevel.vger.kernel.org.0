Return-Path: <linux-fsdevel+bounces-17085-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1008B8A782D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 00:51:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A297E1F239D6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Apr 2024 22:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39BB513A24D;
	Tue, 16 Apr 2024 22:50:44 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail115-171.sinamail.sina.com.cn (mail115-171.sinamail.sina.com.cn [218.30.115.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9581137C33
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Apr 2024 22:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713307843; cv=none; b=GVOmo52IakwVneUDp7QK/vrgSAuo+i1BqCd9QAkzgJsXqLjESsZXHMxXN542blrwhb+HBiaFqvhLTHcS0tvpnkWjINfxNhYVokn5CvHEcLBTq4GL1+/dZTVRVW2eyrAUgBStWB2/8IJapAY97Yu0Zw+EqUUPdOR974+SiSnmmUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713307843; c=relaxed/simple;
	bh=YeW+c02zlbQb6rsuXkQfr7/IYDgDntYzr/uY8KhNTu8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=enCXjm9Cd8WCe0mFWPFDdL+0SzbPE+xxH6HPiI87tKc+AujMknc5S3F3PLdu/5TUyDVmzJQadfOHuDykR4zTtInBpFWPqjXag/3ysJb6gFqvLsw6jQai6Lu8gkrTqP2kifB+w6pR7ZChWW+zdrups2fDX9gFp6JWzAWNbCt8yn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([116.24.8.68])
	by sina.com (172.16.235.25) with ESMTP
	id 661F00B40000621C; Tue, 17 Apr 2024 06:50:31 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 7612834210511
X-SMAIL-UIID: E08D810DB814446B87925F5D9CD96290-20240417-065031-1
From: Hillf Danton <hdanton@sina.com>
To: Jan Kara <jack@suse.cz>
Cc: Amir Goldstein <amir73il@gmail.com>,
	syzbot <syzbot+5e3f9b2a67b45f16d4e6@syzkaller.appspotmail.com>,
	linux-fsdevel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	linux-kernel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [syzbot] Re: [syzbot] [ext4?] KASAN: slab-use-after-free Read in fsnotify
Date: Wed, 17 Apr 2024 06:50:27 +0800
Message-Id: <20240416225027.2499-1-hdanton@sina.com>
In-Reply-To: <20240416173211.4lnmgctyo4jn5fha@quack3>
References: <00000000000095bb400615f4b0ed@google.com> <20240413084519.1774-1-hdanton@sina.com> <CAOQ4uxhh4Tm6j+Hh+F2aQFuHfpCh_kJ10FYTfXo+AxoP4m01ag@mail.gmail.com> <20240415140333.y44rk5ggbadv4oej@quack3> <CAOQ4uxiG_7HGESMNkrJ7QmsXbgOneUGpMjx8vob87kntwTzUTQ@mail.gmail.com> <20240416132207.idn7rjzq4d4rayaz@quack3> <CAOQ4uxjJK3YT1+s_OwtM+=p_C8RCvXaAm6v5V+atyqvRKuKp+g@mail.gmail.com> <20240416173211.4lnmgctyo4jn5fha@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 16 Apr 2024 19:32:11 +0200 Jan Kara <jack@suse.cz>
>
> Hum, thinking about this some more - what if we just freed sb_info from
> destroy_super_work()? By then we definitely are not getting fsnotify()
> calls for the superblock so all the problems are solved.
>
Sounds better :)

