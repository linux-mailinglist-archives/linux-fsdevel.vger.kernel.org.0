Return-Path: <linux-fsdevel+bounces-15312-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9831688C0F9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Mar 2024 12:40:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54B102C3825
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Mar 2024 11:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B86115A0F6;
	Tue, 26 Mar 2024 11:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AMRE/iI4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A215475D;
	Tue, 26 Mar 2024 11:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711453227; cv=none; b=jCaQvjVx3Drdo88I/UTrvHaSCV3WwMsMTJXnutikBm4Gi+noH5fgV0tW03T5q7ZTKLW3+hiZ/YaSfkM0jWwwvGrddEBrR/14Iawp4MIb0hDGrW1D8MeR50boi63daiARFQkdeTKRq4Yk7i/S2xI/F227Uc3ggIchKfLJnHn8FcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711453227; c=relaxed/simple;
	bh=LamHup0dGZLclxF5hDMENi9cqj4fae/k4ItBnLEbvXk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SvaCcxB+eDowncwy7b+2Bo8t4pXlD4Wuo0cPzxSCvPESE8iDd8wPWjugrs3hNwZFaHXZUK3ZReAoA8JqR1g2e5VMFyjXzgdOdfLebW8NCgpVszgOlSqOXXoZwQNu60G3u1bf/UhyybZU1e2apSri8l6wWCnvvtUUxaqq/s9r3kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AMRE/iI4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D913C433C7;
	Tue, 26 Mar 2024 11:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711453226;
	bh=LamHup0dGZLclxF5hDMENi9cqj4fae/k4ItBnLEbvXk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AMRE/iI4RJ6vd0APpjPRk1YQHf4J9dTuv4WrqGL8+E1hr7+otCP/sB5gPa7Rf2wgb
	 IiPE38SuABXhybKzI5dQ/4abJDjcdtLMFsAW68JM0PSqEWKRuomzcmmWP0/lGUolbm
	 rArt7kRg23507Zdd3jlu/crFMF3b5yXeuWkyQvYQiQNIUWoDz6ERDiNJqumC0KnAgY
	 X8pOF+Uqvu+K8HbbMcaKcvHgjpoznL00qAuP4DGdCfgsa98ihYMr7lSYXEeaFsaPXu
	 i0FW42e42lLutB+Qb3CqlrbfFBUjaqAdZS/nSNx+Em/M+fuwezqwvOuUM+8ViviusI
	 1GMEGdZV2mTHw==
Date: Tue, 26 Mar 2024 12:40:20 +0100
From: Christian Brauner <brauner@kernel.org>
To: Roberto Sassu <roberto.sassu@huawei.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Steve French <smfrench@gmail.com>, 
	LKML <linux-kernel@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	CIFS <linux-cifs@vger.kernel.org>, Paulo Alcantara <pc@manguebit.com>, 
	Christian Brauner <christian@brauner.io>, Mimi Zohar <zohar@linux.ibm.com>, 
	Paul Moore <paul@paul-moore.com>, 
	"linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>, 
	"linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>
Subject: Re: kernel crash in mknod
Message-ID: <20240326-halbkreis-wegstecken-8d5886e54d28@brauner>
References: <CAH2r5msAVzxCUHHG8VKrMPUKQHmBpE6K9_vjhgDa1uAvwx4ppw@mail.gmail.com>
 <20240324054636.GT538574@ZenIV>
 <3441a4a1140944f5b418b70f557bca72@huawei.com>
 <20240325-beugen-kraftvoll-1390fd52d59c@brauner>
 <cb267d1c7988460094dbe19d1e7bcece@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cb267d1c7988460094dbe19d1e7bcece@huawei.com>

> we can change the parameter of security_path_post_mknod() from
> dentry to inode?

If all current callers only operate on the inode then it seems the best
to only pass the inode. If there's some reason someone later needs a
dentry the hook can always be changed.

For bigger changes it's also worthwhile if the object that's passed down
into the hook-based LSM layer is as specific as possible. If someone
does a change that affects lifetime rules of mounts then any hook that
takes a struct path argument that's unused means going through each LSM
that implements the hook only to find out it's not actually used.
Similar for dentry vs inode imho.

