Return-Path: <linux-fsdevel+bounces-16861-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A23C98A3CB1
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Apr 2024 14:05:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FF141F21F71
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Apr 2024 12:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EA3B3FB9A;
	Sat, 13 Apr 2024 12:05:18 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail115-79.sinamail.sina.com.cn (mail115-79.sinamail.sina.com.cn [218.30.115.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FAAC381B9
	for <linux-fsdevel@vger.kernel.org>; Sat, 13 Apr 2024 12:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713009918; cv=none; b=e6bMQkt5bQcIN4IdWhkHmCC3gttpueder9h8xXHZd7hV9swMfhLqm014M0uyEfG6V0fzbg6R+F9CDHWhiF6A/g5PSs9M+WdB2lk+cjB3FSupfg8AdvkZXTjfDB9WEwJeH+GVrmfoeRrAIecurw4f3inKNEVZPAshvGoL18qJ6/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713009918; c=relaxed/simple;
	bh=ZwDuFROcMYHb63Lc+jpXgLARAMWwJuw+kBamNEgQdPk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kDzxDoascoq/2LJNyQ0JX1qiCHozdPqngfazVLRXfnuAcdvns/mjWb+oc9eyFNH8OZh07w9vWTGlE6rFZ3HQs/5GwMjEZ3AdqpdZcYTD9K1RHvi1kSpwFO446SgE0lV3JQ7IOZRYmqM7A8sPWzOxcPQjAZRBWp+ILs4eKkWlgvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.88.51.22])
	by sina.com (10.75.12.45) with ESMTP
	id 661A74CE000057DC; Sat, 13 Apr 2024 20:04:32 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 82145831457969
X-SMAIL-UIID: 86D990D479B54C46B1D514ADBD1C56AF-20240413-200432-1
From: Hillf Danton <hdanton@sina.com>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>,
	syzbot <syzbot+5e3f9b2a67b45f16d4e6@syzkaller.appspotmail.com>,
	syzkaller-bugs@googlegroups.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [syzbot] [ext4?] KASAN: slab-use-after-free Read in fsnotify
Date: Sat, 13 Apr 2024 20:04:26 +0800
Message-Id: <20240413120426.1889-1-hdanton@sina.com>
In-Reply-To: <CAOQ4uxhh4Tm6j+Hh+F2aQFuHfpCh_kJ10FYTfXo+AxoP4m01ag@mail.gmail.com>
References: <00000000000095bb400615f4b0ed@google.com> <20240413084519.1774-1-hdanton@sina.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 13 Apr 2024 12:32:32 +0300 Amir Goldstein
> On Sat, Apr 13, 2024 at 11:45=E2=80=AFAM Hillf Danton <hdanton@sina.com> wrote:
> >
> > If you composed fix based on SB_ACTIVE that is cleared in
> > generic_shutdown_super() with &sb->s_umount held for write,
> > I wonder what simpler serialization than srcu you could
> > find/create in fsnotify.
> 
> As far as I can tell there is no need for serialisation.
> 
> The problem is that fsnotify_sb_error() can be called from the
> context of ->put_super() call from generic_shutdown_super().
> 
> It's true that in the repro the thread calling fsnotify_sb_error()
> in the worker thread running quota deferred work from put_super()
> but I think there are sufficient barriers for this worker thread to
> observer the cleared SB_ACTIVE flag.
> 
	do_exit				quota_release_workfn
	---				---
	cleanup_mnt()			ext4_release_dquot()
	__super_lock_excl(s);		__ext4_error()
	deactivate_locked_super(s);	fsnotify_sb_error()
	ext4_kill_sb()
	kill_block_super()
	generic_shutdown_super()
					if (!(sb->s_flags & SB_ACTIVE))
						return;
	sb->s_flags &= ~SB_ACTIVE;
	fsnotify_sb_delete()
					fsnotify()

Because of no sync like taking &sb->s_umount in the worker context,
checking SB_ACTIVE added in your fix is unable to close the race.

> Anyway, according to syzbot, repro does not trigger the UAF
> with my last fix.
> 
Note: testing is done by a robot and is best-effort only.

