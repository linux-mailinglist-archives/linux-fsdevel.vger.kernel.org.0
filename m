Return-Path: <linux-fsdevel+bounces-36489-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CB739E3F7F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 17:21:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 556B1281EBB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 16:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E494D20C47F;
	Wed,  4 Dec 2024 16:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="Cnx2BZ5m"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE1820CCC4
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Dec 2024 16:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733329268; cv=none; b=IBVmdOXWGkIM9BCMy3O76Knp+h+fZ5fdmaV4I1hmtqsxXUiRzL332WpYaAqTlnE77ECJylpyjR+xnKjXvPIfShwmOlEOvrD5zzP606N9+gtDP+mSfUh+i6zRTl3nxVx4MJmoheYfd5M+XnTEuW8vyw8cpc3DdH58IopdqtdA5Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733329268; c=relaxed/simple;
	bh=krsEk3BXneQImqf7XuMSNmpx0SblQqTFLe1N4l5VA3k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ecr7fD+VObr8/kJ3YsKdYHhQ1h+BPRnuwxf80gordww0qokp0JduTZjTbEforjVDf/I08vZnHP8JGaj4LM1ZDJO17fNFurUBs2hz9+7VSNGgcwl1oqSFD5ywln0EYJjOM0rQ9h1lQqR4dc3feW9gUA8BbNiP5YxPoHIs1gWGtoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=Cnx2BZ5m; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=p53t8iZMez4jcRJ04TNPA5c8FLXV/27TaDupjCONLPQ=;
	t=1733329265; x=1734538865; b=Cnx2BZ5mgFXI68vXxtboxO4JruFWuH5tS+HV23I4sRB8gWK
	yKnjybaUjLSfl4P9Efdi3YyxXPOJ6Oyey9wRn34Y/CBPVZyYGFzIqozchSSDeMI+L4lYvtYYpHiFR
	R+cbYm+ZwQ5pAyh4c6DUxI5M46wYmxNK++M6fg9T/KMwfsaXVf8xzvomwIy6W/qPOkcHtHlCJY1S+
	7+JmYpl2b717bJMf25HEOInjbgKvVzIppzY7GTfU9U9w9UyFzseV/hnZsrJE/E3O5MUtJ1S/TIzQA
	NXL23JJrzGKz+Xy6n8hJTwyXW/cy+ACYIePy/IlJbi17KJRGjo1ikGlsop9OU3iA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tIs7Q-000000073t2-2ucC;
	Wed, 04 Dec 2024 17:20:52 +0100
Message-ID: <5b5b50909f7c23f09500d7ecc8b57b46c33ab7b0.camel@sipsolutions.net>
Subject: Re: [PATCH v3 02/13] x86/um: nommu: elf loader for fdpic
From: Johannes Berg <johannes@sipsolutions.net>
To: Hajime Tazaki <thehajime@gmail.com>, linux-um@lists.infradead.org
Cc: ricarkol@google.com, Liam.Howlett@oracle.com, Eric Biederman
 <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara
 <jack@suse.cz>, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Date: Wed, 04 Dec 2024 17:20:51 +0100
In-Reply-To: <215895272109f7b0a4a00625e86b57f39fa13af8.1733199769.git.thehajime@gmail.com>
References: <cover.1733199769.git.thehajime@gmail.com>
	 <215895272109f7b0a4a00625e86b57f39fa13af8.1733199769.git.thehajime@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Tue, 2024-12-03 at 13:23 +0900, Hajime Tazaki wrote:
>=20
>  arch/um/include/asm/Kbuild           |  1 +
>=20
>  arch/x86/um/asm/module.h             | 24 ------------------------
>=20

These changes could be a separate cleanup?

johannes

