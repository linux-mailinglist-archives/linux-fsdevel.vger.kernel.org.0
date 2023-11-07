Return-Path: <linux-fsdevel+bounces-2212-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 497177E3721
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Nov 2023 10:06:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 753941C20B4D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Nov 2023 09:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 799CF12E67;
	Tue,  7 Nov 2023 09:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X6kipn0I"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA39812E40;
	Tue,  7 Nov 2023 09:06:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA22FC433C7;
	Tue,  7 Nov 2023 09:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699347989;
	bh=7Ly4OM2ZT9sUuel1E6UbZEzeZO7DWAxSaQOEMrXEdHo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X6kipn0I5G4QbPZeMULAxzyByDh1oxcRGZ7s5eDyuYEcxNzFyUFId0XAD5i5hIxGm
	 uUxDLPgA9ce8hPjFV7LrtM7bQoS8zjGoCnxNQ9ngIy9Cc8WQtHAhtxWWoSDSOJcj8H
	 UTsAhermqN6rtDIVQHyM66DodwecQLPfAnChsLwk9zNmoydK9yj76LwvjlcWZDS6C/
	 DQlxVORgNisQDgaSfitIiVaCP51shGZh2b+zuWRFkM7p3OQFNXqF+JOGQY/SdlYQhk
	 yfU6QLS3+JOWNl/G8fDN18hy8njJuV/VKpSorsdd1oUkKp1WUE12iu4xYYrcskZmTp
	 nl1fkEYbq3nJw==
Date: Tue, 7 Nov 2023 10:06:18 +0100
From: Christian Brauner <brauner@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	Qu Wenruo <quwenruo.btrfs@gmx.com>,
	Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
	Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/3] fanotify support for btrfs sub-volumes
Message-ID: <20231107-leiden-drinnen-913c37d86f37@brauner>
References: <20231102051349.GA3292886@perftesting>
 <20231102-schafsfell-denkzettel-08da41113e24@brauner>
 <ZUUDmu8fTB0hyCQR@infradead.org>
 <20231103-kursleiter-proklamieren-aae0a02aa1a4@brauner>
 <ZUibZgoQa9eNRsk4@infradead.org>
 <20231106-fragment-geweigert-1d80138523e5@brauner>
 <ZUjcI1SE+a2t8n1v@infradead.org>
 <20231106-unser-fiskus-9d1eba9fc64c@brauner>
 <ZUker5S8sZXnsvOl@infradead.org>
 <20231106224210.GA3812457@perftesting>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231106224210.GA3812457@perftesting>

> But it doesn't appear to me there's agreement on the way forward.  vfsmounts
> aren't going to do anything from what I can tell, but I could very well be
> missing some detail.  And Christian doesn't seem to want that as a solution.

No, I really don't.

I still think that it is fine to add a statx() flag indicating that a
file is located on a subvolume. That allows interested userspace to
bounce to an ioctl() where you can give it additional information in
whatever form you like.

