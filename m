Return-Path: <linux-fsdevel+bounces-12495-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0146185FE10
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 17:28:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83D1DB267FD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 16:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4EE3153505;
	Thu, 22 Feb 2024 16:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LSSOSWpv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D23130E32;
	Thu, 22 Feb 2024 16:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708619312; cv=none; b=R5LZAY6ByT1/2lycbu7JQJj/u/QtvfDmBsey8xtQ5E/6skjHQdychmhZN0h4cHz+8rVR70t7kLC0hFptOQuh3gsXt5eGZjq4cek6LAE1ai0oARchok+kRwE67h4fdDYTrzKsDDEBZzQ0D+J7vUFesTO3hruTv4oLEaAN5lvi8I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708619312; c=relaxed/simple;
	bh=/N54fL35ZdVbtebauo84ov69w0sjILFhff+gvM1V4NQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UmEvtRKf/RjR1Gmp5csvavt0vx7rs1oVBpn7P+fSq2boaWeRGFTc3b5r2I7yfKnsJZw0gH5PaAzN6HxcZzuhvrdudRH3MxaLsO8aHHuph7yFCqtzavUWE6AuKXYwWbvmqJbaIPwOu5tDx+pQksMG4r0n9C/kmptCrR8umZUPC1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LSSOSWpv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AF65C433C7;
	Thu, 22 Feb 2024 16:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708619311;
	bh=/N54fL35ZdVbtebauo84ov69w0sjILFhff+gvM1V4NQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LSSOSWpvtYIZUdKHdK5v726xYpd5If9zSDsal9KwYkamz32CsMORMaSaXI/72Bpg5
	 22nEvBfXATGQPWXLadPhkOf6zHZgnVGaZQiW8KPJ2qugrI6tPe102a1KHsvoG+SHft
	 nbLUkVuCRBv651s92Fc5UZWHtM9ev5xHVp4EIMgBMRAfCAqQ7ndd9W/ra89WBBWaYN
	 loO2sTQELS5Qlk8MfRrVk3XeU2P4r+0CghckSCRoK7L+inB85apxFx7No8AVC6vshv
	 4x3f+HqI2OZp/pbxliU0m95ZleWOQ41TUq605vpcdWwnIf74RMBZDIrfIjJo31Xdq/
	 SrNw0kNrsqdUg==
Date: Thu, 22 Feb 2024 10:28:30 -0600
From: "Seth Forshee (DigitalOcean)" <sforshee@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Serge Hallyn <serge@hallyn.com>, Paul Moore <paul@paul-moore.com>,
	Eric Paris <eparis@redhat.com>, James Morris <jmorris@namei.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org, audit@vger.kernel.org,
	selinux@vger.kernel.org, linux-integrity@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-unionfs@vger.kernel.org
Subject: Re: [PATCH v2 00/25] fs: use type-safe uid representation for
 filesystem capabilities
Message-ID: <Zdd2LuUpQDldrkVO@do-x1extreme>
References: <20240221-idmap-fscap-refactor-v2-0-3039364623bd@kernel.org>
 <20240222-fluchen-viren-50e216b653fb@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240222-fluchen-viren-50e216b653fb@brauner>

On Thu, Feb 22, 2024 at 04:27:50PM +0100, Christian Brauner wrote:
> I still think that the generic_{get,set,remove}_fscaps() helpers falling
> back to plain *vfs_*xattr() calls is a hackish. So ideally I'd like to
> see this killed in a follow-up series and make all fses that support
> them use the inode operation.

Right, you brought this up last time, and I probably should have
mentioned it in the cover letter. I haven't seriously looked at doing
this yet, in large part because I got interrupted from working on this
and felt like v2 patches were long overdue (and you said you were fine
with doing it as a follow-up series anyway). But I will have a look to
see if it makes sense to change that in the next version of this series.

