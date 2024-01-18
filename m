Return-Path: <linux-fsdevel+bounces-8259-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DFE8831BA6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jan 2024 15:41:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8636B28AF32
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jan 2024 14:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E8C82941F;
	Thu, 18 Jan 2024 14:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GsE7mzch"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7948628DBC;
	Thu, 18 Jan 2024 14:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705588807; cv=none; b=ZQhhGJglnEoUlmqSp5nqkoSZupY4KhEo5aXnSA3G2OLiDMFi3MPhdQzluZqSGCc3F12h7pJmChwO9r+AbPeqzpS9094xxCNNaIj72hoDlO8XX6FBSIQiZ1ubMI0BE1p1MlR4lJM0jT7QTKzIme/nLzHU8/3xuIdtCbE7N/5Uv3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705588807; c=relaxed/simple;
	bh=1nGWSp2zbP5zgxUJ8GSxRXbppy2TjMZIkx7qciwfVuU=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To; b=o//1jMTVITXsIuyxpxsqKkcxCG6g5nsyHgR3i+YS0ipzCmfCs4uD2JtgwPYl7WsRfZq1BnOdfClcg6NfjSc3wRBaoFSJEYgErx8ddj0aTHST22A4TrGUGucYKZP4XK8UkV2Rrrf3z0rUNLvp10SVgeTMtmXZuF7Ni/e8b1ody7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GsE7mzch; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2121C43390;
	Thu, 18 Jan 2024 14:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705588807;
	bh=1nGWSp2zbP5zgxUJ8GSxRXbppy2TjMZIkx7qciwfVuU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GsE7mzchC2s7r2VpOmfcp3QvxQXlGFOFsAYC1iBrR1oMYD65tocIuxZi9vVBxClP9
	 zamWGzAShyLQR2o7kN43PX4G8bW0Mt5KeNWLDdvgcAtvnEtk7WvwjLrBFX7MJon/fI
	 kJSJMgLaikOopKrzAbwN0pURT2XHAUSByDaIBTXBlVhqnvRSHdawO1Ch9g3p6jd3ws
	 KOLiND4rWH2eO/mpzC7Odx1TrajDypR960RTn/CZ62UIOrMZNUpgoQ94mUtZJrSHJ7
	 g3/DDUqiePBG4u/MGqU7DCH5sCdvw/Eg6ghChp59ZRSkdE2a8DwxacaNSDxqOVXJbb
	 sn9k2EPFf6RZA==
Date: Thu, 18 Jan 2024 15:40:02 +0100
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: syzbot <syzbot+3abaeed5039cc1c49c7c@syzkaller.appspotmail.com>, 
	axboe@kernel.dk, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	reiserfs-devel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [reiserfs?] possible deadlock in chown_common
Message-ID: <20240118-badeverbot-gemustert-e87bd2a23bfc@brauner>
References: <0000000000006308a805eaa57d87@google.com>
 <000000000000b5b973060f269eb3@google.com>
 <20240117165236.kcmlvjedoae6yd76@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240117165236.kcmlvjedoae6yd76@quack3>

On Wed, Jan 17, 2024 at 05:52:36PM +0100, Jan Kara wrote:
> On Wed 17-01-24 08:20:06, syzbot wrote:
> > syzbot suspects this issue was fixed by commit:
> > 
> > commit 6f861765464f43a71462d52026fbddfc858239a5
> > Author: Jan Kara <jack@suse.cz>
> > Date:   Wed Nov 1 17:43:10 2023 +0000
> > 
> >     fs: Block writes to mounted block devices
> > 
> > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14ecbc83e80000
> > start commit:   2bca25eaeba6 Merge tag 'spi-v6.1' of git://git.kernel.org/..
> > git tree:       upstream
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=9df203be43a870b5
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3abaeed5039cc1c49c7c
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1539e7b8880000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16c6cb32880000
> > 
> > If the result looks correct, please mark the issue as fixed by replying with:
> 
> Makes sense:
> 
> #syz fix: fs: Block writes to mounted block devices

I remember once trying to chase that bug down and being very confused.

