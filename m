Return-Path: <linux-fsdevel+bounces-2368-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 598D07E51E2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Nov 2023 09:22:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D67F3B21070
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Nov 2023 08:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89B38DDC3;
	Wed,  8 Nov 2023 08:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DJiNayvF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F9DDDA9;
	Wed,  8 Nov 2023 08:22:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12900C433C7;
	Wed,  8 Nov 2023 08:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699431759;
	bh=3Vj0nWDClnQJEe8ABsbPvGD0pkB8VRY9gKcXZpllqbI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DJiNayvF/mMQcgwaluVRu82fbnLE+2c+UaqwOnmyrGm2cwrZY5wxZCrNfGIFuW43n
	 tfluZwvhTCG0ocBIp3F5F4VQ/IAztQa4z6Ven/o58AzdZkHJeZDIBlVcJQHvb6NdDZ
	 WNt502GVYWH/vRuPHLxWFE8AiTYdShld33i6qNhy5yFke8TAOwRKlE5GUm8BifgPvw
	 +sZMwk6nplhxwOsTVZT4HYIxqEkNiqBZ/AsBwKprD50qbC2VP9dTTewCu47yYGVBDc
	 TtrI3L6cYbz/ooCgmDFTEwoP4S6a+/TZxZvPn7yTXmli3q2QS67ngaMugwAI8cZ6lz
	 k28TSWj+Rz8hA==
Date: Wed, 8 Nov 2023 09:22:33 +0100
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Qu Wenruo <quwenruo.btrfs@gmx.com>, Josef Bacik <josef@toxicpanda.com>,
	Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
	Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/3] fanotify support for btrfs sub-volumes
Message-ID: <20231108-regimekritisch-herstellen-bdd5e3a4d60a@brauner>
References: <20231106-fragment-geweigert-1d80138523e5@brauner>
 <49454bf2-af6e-4dcf-b9a1-22acbfdc756d@gmx.com>
 <20231106-postfach-erhoffen-9a247559e10d@brauner>
 <ZUjcgU9ItPg/foNB@infradead.org>
 <20231106-datei-filzstift-c62abf899f8f@brauner>
 <ZUkeBM1sik1daE1N@infradead.org>
 <20231107-herde-konsens-7ee4644e8139@brauner>
 <ZUs/Ja35dwo5i2e1@infradead.org>
 <20231108-labil-holzplatten-bba8180011b4@brauner>
 <ZUtC9Bw70LBFcSO+@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZUtC9Bw70LBFcSO+@infradead.org>

On Wed, Nov 08, 2023 at 12:12:36AM -0800, Christoph Hellwig wrote:
> On Wed, Nov 08, 2023 at 09:09:10AM +0100, Christian Brauner wrote:
> > > a bind mount can of course change the dev_t - if it points to a
> > > different super block at the moment.
> > 
> > No, a bind mount just takes an existing directory tree of an existing
> > filesystem and makes it visible on some location in the filesystem
> > hierarchy. It doesn't change the device number it will inherit it from
> > the superblock it belongs.
> 
> That's what I'm trying to say.
> 
> So if you have:
> 
> 	/mnt/1/ with dev 8
> 	/mnt/2/ with dev 23
> 
> then a bind mount of
> 
> 	/mnt/1/foo to /mnt/2/bar will get your dev 8 for /mnt/2/bar
> 
> So the device number changes at the mount point here, bind mount or not.

Yes, I know. But /mnt/2/ will have the device number of the
superblock/filesystem it belongs to and so will /mnt/1. Creating a
bind-mount won't suddenly change the device number and decoupling it
from the superblock it is a bind-mount of.

