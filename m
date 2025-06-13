Return-Path: <linux-fsdevel+bounces-51555-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0457AD83AC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 09:08:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E14893B919B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 07:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62CD825A624;
	Fri, 13 Jun 2025 07:08:29 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759271632DD;
	Fri, 13 Jun 2025 07:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749798509; cv=none; b=bpKNFuGdpm4txVDCharWdQOMjLuzfjdq5VlJ+t69PnMM/HAv9h6v3cw1PeFpxdEkitAOn1Y36K+xL+SZuzq+0O+aJsC+JmMfcfQmlfP1mMZWfMzyz6cZlbBNcflcLvG3qlmUgBbf6t4oL84pV9jTFLnXv5ZE4wmHXD4uXua0WFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749798509; c=relaxed/simple;
	bh=D0lbE0R+FUdn+WoBoKcNI9HgS1w92fraWDayJ3fxKs0=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=F4hxhdbRZUjY0Xu4292DTRJumzs2r81UEzVzJIA0U/9n+GUfAF1N/44T9Ricrxu1yFnQ6qKrPpcNRAymO+OIUGWyyw6Z5YTjrRK1dYSic8GDD5H1c8AVzfpzmn3IJ2mEGO3arAORrdYJYlxu+nBT5M/egmt7MJ7A6zXRHe7mBYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1uPyWN-00A9fw-3B;
	Fri, 13 Jun 2025 07:08:15 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neil@brown.name>
To: "Miklos Szeredi" <miklos@szeredi.hu>
Cc: "Al Viro" <viro@zeniv.linux.org.uk>,
 "Christian Brauner" <brauner@kernel.org>, "Jan Kara" <jack@suse.cz>,
 "David Howells" <dhowells@redhat.com>, "Tyler Hicks" <code@tyhicks.com>,
 "Chuck Lever" <chuck.lever@oracle.com>, "Jeff Layton" <jlayton@kernel.org>,
 "Amir Goldstein" <amir73il@gmail.com>, "Kees Cook" <kees@kernel.org>,
 "Joel Granados" <joel.granados@kernel.org>,
 "Namjae Jeon" <linkinjeon@kernel.org>, "Steve French" <smfrench@gmail.com>,
 "Sergey Senozhatsky" <senozhatsky@chromium.org>, netfs@lists.linux.dev,
 linux-kernel@vger.kernel.org, ecryptfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
 linux-unionfs@vger.kernel.org, linux-cifs@vger.kernel.org
Subject: Re: [PATCH 1/2] VFS: change old_dir and new_dir in struct renamedata
 to dentrys
In-reply-to:
 <CAJfpeguiOZJ4dZU-mc0V8bwvWoJ-Q0JubYvYPpmr-f8uguF2LQ@mail.gmail.com>
References:
 <>, <CAJfpeguiOZJ4dZU-mc0V8bwvWoJ-Q0JubYvYPpmr-f8uguF2LQ@mail.gmail.com>
Date: Fri, 13 Jun 2025 17:08:13 +1000
Message-id: <174979849395.608730.16231142843321576358@noble.neil.brown.name>

On Thu, 12 Jun 2025, Miklos Szeredi wrote:
> On Thu, 12 Jun 2025 at 01:38, Al Viro <viro@zeniv.linux.org.uk> wrote:
> 
> > Umm...  No objections, as long as overlayfs part is correct; it seems
> > to be, but I hadn't checked every chunk there...
> 
> Overlayfs parts looks okay too.
> 
> A followup would be nice (e.g. make ovl_cleanup() take a dentry for
> the directory as well, etc) so that there's no need to have local
> variables for both the inode and dentry of the directory.

I am planning some followups and will include that in them.
I'll also be sure to test with fs-tests after consulting README.overlay
as you suggest elsewhere - thanks.

NeilBrown

