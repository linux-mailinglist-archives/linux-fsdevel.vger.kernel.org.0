Return-Path: <linux-fsdevel+bounces-70305-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AB97C9647E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 01 Dec 2025 09:57:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 754A23A2FD2
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Dec 2025 08:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC9252FE041;
	Mon,  1 Dec 2025 08:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="UjaKIBG4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1BD79CF;
	Mon,  1 Dec 2025 08:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764579414; cv=none; b=Ni/HZJcDMZHoyXj04Jl/VG+ypvK/hboTh1hRSpnqM+ONhAiqiZnpbXt/8SE60K4E1hSF/HHw8gEx11uEwJUkdF5trMW8LyL/YelvXzu7j6KEU3SmmEUHzYr1snwEBFyOW2QoG8X0KN8N6weNa9yaRqelfRtceZxThBMJcEZXmvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764579414; c=relaxed/simple;
	bh=6dla5ERP6+TMe3AfXj7ITl1AnsW1gVgvLg751Sz37jg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CDr2sPjSt0KF9k+O6iDzbi87bVX8jR+D+xlG9MRkGuhs8Jlqnz9R6erV79984luXeYDQqmrw2/ZXkbrLrlG61QwhLyGshpHa8RHNH38/iu8pT4TnbyH4SVkvWJ/q4d/S+7I5Smie7K3F69byAjBGPKVCIRvEm2JYF/GpPBep8Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=UjaKIBG4; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=rrn7D0P5n1e0fR6aGl0DImJbO/qeWFoSquF9J8zV4mU=; b=UjaKIBG40b85GrsHttp47seGRC
	p4qmkrLU77H9e4daaGS5ULNmQTt5cF1/MHzbX8KmvZf5ljX41Ef8aoA2bCkIowrq9pNJfSiYluLAe
	zqbICjcc0Uh8DfY+flGbExboFlJJzaltfmlxi59cQsIosr1HIQ+0FdMBeKJBiF58AdlAMjygv43UV
	yP4OCncH0lwCiqjEpIRm+fvz/YAEGPb+fCFvbbA7vqNl2WKQ4YImvI9LzM4meK4dP/1hc0SPqt14T
	940C9T47HeTgOPYlgp/wtFl/ChAsRvf/tBPSwRoAJZjPP0lLPLdfq/hg0B0oTyKgrstzG5a/droaa
	R/neCAUA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99 #2 (Red Hat Linux))
	id 1vPziN-0000000CAjr-1YzQ;
	Mon, 01 Dec 2025 08:56:59 +0000
Date: Mon, 1 Dec 2025 08:56:59 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: NeilBrown <neil@brown.name>
Cc: Amir Goldstein <amir73il@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	Val Packett <val@packett.cool>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
	Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
	David Howells <dhowells@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, Tyler Hicks <code@tyhicks.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Chuck Lever <chuck.lever@oracle.com>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <smfrench@gmail.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Carlos Maiolino <cem@kernel.org>,
	John Johansen <john.johansen@canonical.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	Mateusz Guzik <mjguzik@gmail.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Stefan Berger <stefanb@linux.ibm.com>,
	"Darrick J. Wong" <djwong@kernel.org>, linux-kernel@vger.kernel.org,
	netfs@lists.linux.dev, ecryptfs@vger.kernel.org,
	linux-nfs@vger.kernel.org, linux-unionfs@vger.kernel.org,
	linux-cifs@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Subject: Re: [PATCH] fuse: fix conversion of fuse_reverse_inval_entry() to
 start_removing()
Message-ID: <20251201085659.GC3538@ZenIV>
References: <20251113002050.676694-1-neilb@ownmail.net>
 <20251113002050.676694-7-neilb@ownmail.net>
 <6713ea38-b583-4c86-b74a-bea55652851d@packett.cool>
 <176454037897.634289.3566631742434963788@noble.neil.brown.name>
 <CAOQ4uxjihcBxJzckbJis8hGcWO61QKhiqeGH+hDkTUkDhu23Ww@mail.gmail.com>
 <176457904303.16766.13791656192264803692@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <176457904303.16766.13791656192264803692@noble.neil.brown.name>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Dec 01, 2025 at 07:50:43PM +1100, NeilBrown wrote:

> Why was the original code locking the parent inode?  Whatever that was
> protecting, we need to keep protecting it.  That is what
> start_removing_dentry() is there to do.

We need to find out what it's protecting, rather than cargo-culting it
indefinitely.  If nothing else, it's a place with uncommon use of
inode_lock; we need to know which properties of current locking
scheme does it expect there.  Thus the question to Miklos...

