Return-Path: <linux-fsdevel+bounces-23244-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 91997928D83
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jul 2024 20:28:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2CABAB23ED9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jul 2024 18:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 043E516DC22;
	Fri,  5 Jul 2024 18:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R6h4ROaN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6271314B075;
	Fri,  5 Jul 2024 18:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720204086; cv=none; b=GfEKeJfgJrDNK0k271jmTTbFC251yQTvL3WbTSIZuoTGpd10UkS3z22rZk19AqGh7rkL9BpbG0/u8UcInWvQKYh/EhtGOP3Qh6NUG/EP2c1jqOYGSmHbf2sXplsfY1jPVo8MASodX8444fQEoOYH8me3RwGPWDSaV0qjGM/drmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720204086; c=relaxed/simple;
	bh=KmcElzmESUIp0MlELsh9o4w4XilOqKmLaFJjxt90rE8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aTorCeu8RXg/WDZ4K+ApRqtbiKklMw3/VKPE2qygPfWdwfJRAFsiqPPqAx7ThPcE+MvFCoVC7FeTfKsfRRJsNF56t9XARO4Gxkgkya/sDf6HqKtRwSQERsnxeWlR72cT6NjTvEiOZR6rMjYXnFAdYlsfc7J7Ie9K4FfQGLK08j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R6h4ROaN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 791DAC4AF07;
	Fri,  5 Jul 2024 18:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720204085;
	bh=KmcElzmESUIp0MlELsh9o4w4XilOqKmLaFJjxt90rE8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R6h4ROaNUpRDGTTQQZoqX6QawFmfSQAYU/GSM4Vh9/Yw8h9o1n6/w6lUspzJRe1nk
	 Y3pU/C9z76LYIfANKBvu6N0FkbBZC3+adqjD6p8/a+ZvbyFJTeReIYmGWCZLbb0uVI
	 NBNhdhz8AgCM6kP9tmMLXvQ6W3jayrYBL1a5AND4/tCjcsEg+AP6xUzJoFB7LhUYxB
	 qEVZIjAxqVe0MQ+gRe/yBn64BbOEhXiRqTZnQJcym0fKkH5UtkbzdymaGlT0c4vN6Y
	 EjXWrwgah6nJfBUx6SZFzlY6PwM4lFzIZArq7mijYP+kI83NFOmeY55TQ1PfvhJWeH
	 Zu9ElDZb7ROvg==
From: SeongJae Park <sj@kernel.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Matthew Wilcox <willy@infradead.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Eric Biederman <ebiederm@xmission.com>,
	Kees Cook <kees@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Shuah Khan <shuah@kernel.org>,
	Brendan Higgins <brendanhiggins@google.com>,
	David Gow <davidgow@google.com>,
	Rae Moar <rmoar@google.com>
Subject: Re: [PATCH v2 7/7] tools: add skeleton code for userland testing of VMA logic
Date: Fri,  5 Jul 2024 11:28:01 -0700
Message-Id: <20240705182801.95577-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <7989012e4f17074d3b94803dcebb8c3d1365ca1d.1720121068.git.lorenzo.stoakes@oracle.com>
References: 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Lorenzo,

On Thu,  4 Jul 2024 20:28:02 +0100 Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:

> Establish a new userland VMA unit testing implementation under
> tools/testing which utilises existing logic providing maple tree support in
> userland utilising the now-shared code previously exclusive to radix tree
> testing.
> 
> This provides fundamental VMA operations whose API is defined in mm/vma.h,
> while stubbing out superfluous functionality.
> 
> This exists as a proof-of-concept, with the test implementation functional
> and sufficient to allow userland compilation of vma.c, but containing only
> cursory tests to demonstrate basic functionality.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

I haven't had a time to review this, and I don't think I will get the time soon
(don't wait for me).  But, I was able to build and run it as below, thanks to
the fast runtime of the test ;)

    $ cd tools/testing/vma
    $ make
    [...]
    $ ./vma
    4 tests run, 4 passed, 0 failed.

So, FWIW,

Tested-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]

