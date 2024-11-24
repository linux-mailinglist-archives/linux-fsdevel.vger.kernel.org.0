Return-Path: <linux-fsdevel+bounces-35708-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 175E89D776A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Nov 2024 19:38:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF7E9B2DC24
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Nov 2024 16:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9A4418859F;
	Sun, 24 Nov 2024 16:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="Uv+Nhptk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B462500C5
	for <linux-fsdevel@vger.kernel.org>; Sun, 24 Nov 2024 16:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732464070; cv=none; b=GL/+s15DBAtjnOan7ptSmukIFwKSaXGzi9VmAkKXuyjbC+aK0mKzR+H1dmE5CB2+qqKvfa+pCs6Ahjm86V4EsONx83+J6teqn4odMwgoVr+ZdtlOqX6S1iLIRS5TSsWTCyDMjM6EAJ5ge7OaJ/1kQfpjtKTVSUuJzh2nzJOgD08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732464070; c=relaxed/simple;
	bh=Sf2MTihRGbCzA9KzLK1IO48wXW7JUnu8n4umANxIRQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uU9VFzlrqBOw6O8VgKMvBC45T7fxDI0Qgf96LvzkGhg71hp/PLqgWZs1LmGjtg+LEI2POUfc1W7IDHbQc63IzGOxmFhF3+3wYZ5fFGbc/ypa6NKEmlWZ3cx8sUsB1NKrkfn1bV3kPfGgi7lX1mIoRqnWaCOOcMavvE500FO9yS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=Uv+Nhptk; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from macsyma.thunk.org (syn-098-147-040-133.biz.spectrum.com [98.147.40.133])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 4AOFxtZw003163
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 24 Nov 2024 10:59:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1732464000; bh=2w6rzDBqZDK836MybJ78ZxuL/o1JL2jaY8GwyU8vRy8=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=Uv+NhptkVd6SGZkhvfe2HViuBEf9uF44mw8F0pi4PmRyL/Pg0jVzXrdEoDha2NpNi
	 csQYj2RWZJ2ZHgPDYWagfRuls1GA770238Pk4PInSwyEboeYs2Ww39D6egVkXxM/e4
	 bvZW02uoU9v9MCMijuxLM7FJQSNXGcK2ubAKe2uEsKgmQQBLHDHLTINBAtZACYvMAp
	 cw2B4ajAbiQP0XWP9MP9VMqmpdN4Usod06wQam5G7oJIifzcqgysjEdBOBNu1UXxPU
	 Zd602lTPvWDmQyq2Z7J7jmXaAE7ts8r+6KG9dNrT7Ko+XoKMkrnhX/jE8NVN8QMywL
	 awoa1+QKJuHvg==
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id 2CD6C341253; Sun, 24 Nov 2024 10:59:55 -0500 (EST)
Date: Sun, 24 Nov 2024 05:59:55 -1000
From: "Theodore Ts'o" <tytso@mit.edu>
To: Jinliang Zheng <alexjlzheng@gmail.com>
Cc: viro@zeniv.linux.org.uk, adobriyan@gmail.com, alexjlzheng@tencent.com,
        brauner@kernel.org, flyingpeng@tencent.com, jack@suse.cz,
        joel.granados@kernel.org, kees@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mcgrof@kernel.org
Subject: Re: [PATCH 0/6] Maintain the relative size of fs.file-max and
 fs.nr_open
Message-ID: <20241124155955.GD3874922@mit.edu>
References: <20241123193227.GT3387508@ZenIV>
 <20241124094813.1021293-1-alexjlzheng@tencent.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241124094813.1021293-1-alexjlzheng@tencent.com>

On Sun, Nov 24, 2024 at 05:48:13PM +0800, Jinliang Zheng wrote:
> > 
> > Short version: there are 3 different notions -
> > 	1) file as a collection of data kept by filesystem. Such things as
> > contents, ownership, permissions, timestamps belong there.
> > 	2) IO channel used to access one of (1).  open(2) creates such;
> > things like current position in file, whether it's read-only or read-write
> > open, etc. belong there.  It does not belong to a process - after fork(),
> > ...
>
> I'm sorry that I don't know much about the implementation of UNIX, but
> specific to the implementation of Linux, struct file is more like a
> combination of what you said 1) and 2).

This is incorrect.  In Linux (and historical implementations of Unix)
struct file is precisely (2).  The struct file has a pointer to a
struct dentry, which in turn has a pointer to a struct inode.  So a
struct file *refers* to (1), but it is *not* (1).

       	    	     	     	       	     - Ted

