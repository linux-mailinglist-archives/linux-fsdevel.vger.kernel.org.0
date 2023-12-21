Return-Path: <linux-fsdevel+bounces-6634-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E95D581B043
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Dec 2023 09:27:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5D892860C2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Dec 2023 08:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57CDA171B3;
	Thu, 21 Dec 2023 08:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nioerWnK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D6C168A3;
	Thu, 21 Dec 2023 08:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
	:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=s5bF4a3oGHwRzhZloQgs1py2PtbiD8YbppXPrzeqwbA=; b=nioerWnK9UmuutYnZj7Kp3QwZu
	gdzZzbiPuJDuIpBGu1tEMOiHeEweD17H3Bf/T+JZpIofNJ9ixWWE8FNTS9isrUb/KsIR6iA/btVEg
	44SUTE/EzQqqIkfQnMb0CrHrGV6ofH6Kz9Hpan5cc8JM0GE+X3aTmk+sZ6z2DD8sj9gYtj3mFL3EU
	Eimb8fbbyl8Kb7NzS973TNxCMeIsX1RiEIUE8f4NG8Ku/K3s17dKpuWvlUBb+XM0ZgDX/64Eyhbdx
	0KSaTq/P0Rvrc/bTOCf/KXHtn8c9jvZYpJgsQRdDPNleanbNzKG01TEUYGIDvS/jOvBIKv8UUCOU/
	Qfi1RubQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rGEOe-0022BA-08;
	Thu, 21 Dec 2023 08:27:12 +0000
Date: Thu, 21 Dec 2023 00:27:12 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>
Cc: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/11] splice: copy_splice_read: do the I/O with
 IOCB_NOWAIT
Message-ID: <ZYP24DCMYiwc6V/4@infradead.org>
References: <cover.1703126594.git.nabijaczleweli@nabijaczleweli.xyz>
 <d87ac02081f2d698dde10da7da51336afc59b480.1703126594.git.nabijaczleweli@nabijaczleweli.xyz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d87ac02081f2d698dde10da7da51336afc59b480.1703126594.git.nabijaczleweli@nabijaczleweli.xyz>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Dec 21, 2023 at 04:08:45AM +0100, Ahelenia Ziemiańska wrote:
> Otherwise we risk sleeping with the pipe locked for indeterminate

You can't just assume that any ->read_iter support IOCB_NOWAIT.


