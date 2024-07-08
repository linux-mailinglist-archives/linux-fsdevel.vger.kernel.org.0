Return-Path: <linux-fsdevel+bounces-23326-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D75E92A9C5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jul 2024 21:25:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 233511F227EB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jul 2024 19:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62B0414D443;
	Mon,  8 Jul 2024 19:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g7ITPl/Y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA66E146D74;
	Mon,  8 Jul 2024 19:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720466725; cv=none; b=pcdPEGZUPOO/s/SRRdKUqcH1jdjeBZPVxB4b5UQFbqG17K/QpxxRJaoLcGvFCeadeAC/ZV3i3ToNZhduxYQSUNxz4XZ73/d5WYL8kkh/INQ6Vivts9UEjTGJBfVp8wqj/x1nK52gl6x55Dp0xjKQL64FghFg18lC9IdpEbPvkxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720466725; c=relaxed/simple;
	bh=00atE34j6ms2OSoAiI9UsMIbCTUmOELus01jENuLCtY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c7ii3QMqVQ51vYmYAGzFEfenUUDXqod8wX02ieI5CIomEAnVJP2pvDmgSGC/kK3tElI6+C1JnjmXajNi9eCw507KsY1SUs16hMA0u9RIAhyE25vAb+XTAHdDO/MCq05Ot9F1v1erUvYqbUbnaohSGsizR3LHusm30h5b3P4PbGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g7ITPl/Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37DAEC116B1;
	Mon,  8 Jul 2024 19:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720466725;
	bh=00atE34j6ms2OSoAiI9UsMIbCTUmOELus01jENuLCtY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g7ITPl/Y98H9rhde1XEjifNOPyYFRY7WmOdgM8lXDxy4pNZMEV8UMVYXDjSFSMOZS
	 xkmlaeV7kfl3s8ObzMLsT50svXZ7Rw3nV8nbL48JUBGzrsrNh5Qi9QK9ufQww7ook4
	 Y1Z5AV5EWyES3M+hM5KJ37zznZs9LlPkwRDcGj2igKjsfGGuwSCIWVRWTwH6QZV1vG
	 zukPXELlxsyz+0SNw15+i9lmfNLlXwgVjjQhyW4/ERgQI70Bi9zLoZD3hlNAriP4aB
	 HWctosMzsMiZBzWXcDINZU5jZeLTClBB0HWXLIaHCOp8B4quk7q+GaF6r1Q3pqmYu4
	 Kqbyb72tO34WA==
Date: Mon, 8 Jul 2024 12:25:24 -0700
From: Kees Cook <kees@kernel.org>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: Christian Brauner <brauner@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Paul Moore <paul@paul-moore.com>, Jann Horn <jannh@google.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Casey Schaufler <casey@schaufler-ca.com>,
	syzbot <syzbot+5446fbf332b0602ede0b@syzkaller.appspotmail.com>,
	jmorris@namei.org, linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org, serge@hallyn.com,
	syzkaller-bugs@googlegroups.com, linux-fsdevel@vger.kernel.org
Subject: Re: [syzbot] [lsm?] general protection fault in
 hook_inode_free_security
Message-ID: <202407081222.D8E3CAEC@keescook>
References: <00000000000076ba3b0617f65cc8@google.com>
 <CAHC9VhSmbAY8gX=Mh2OT-dkQt+W3xaa9q9LVWkP9q8pnMh+E_w@mail.gmail.com>
 <20240515.Yoo5chaiNai9@digikod.net>
 <20240516.doyox6Iengou@digikod.net>
 <20240627.Voox5yoogeum@digikod.net>
 <202406271019.BF8123A5@keescook>
 <20240708.hohNgieja0av@digikod.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240708.hohNgieja0av@digikod.net>

On Mon, Jul 08, 2024 at 04:02:34PM +0200, Mickaël Salaün wrote:
> I think your patch is correct though.  Could you please send a full
> patch?

Can you take it over? I don't have an immediate reproducer, etc. I think
it'd be best for the changes to go along with fixes for Landlock and Smack.

-- 
Kees Cook

