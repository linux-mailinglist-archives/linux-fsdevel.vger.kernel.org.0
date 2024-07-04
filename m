Return-Path: <linux-fsdevel+bounces-23084-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44EB0926D18
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jul 2024 03:26:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7672A1C21820
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jul 2024 01:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87A62C8FE;
	Thu,  4 Jul 2024 01:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="VtbfgnNd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58922581;
	Thu,  4 Jul 2024 01:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720056397; cv=none; b=HY7uBcdM1Cx5EKQJFbLwga7dFWx862oc+hdC81vb2Je4gEufL8CgkmGKFKFfU+7Gc9mPg9/85ndENievp3uqvFLFVGOP8PqSRSLGIM3rPfdQsB+FjWodtjMe+PZs4y0AHUieQz/ZbYjJIuz9dTSm4ikAzhn0TTzAM9qOnJgpq+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720056397; c=relaxed/simple;
	bh=GkVtuwbf8p9cXqHz8uwyctRlpGOGEOw/zHNi1c8dusk=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=keHeLCiSgwE72jQe8+qyydmezzv8UdCWODp1GH4laPOfq1tsXDJ2NGuVRGZ0w8fL25XBZcKXEsK+xxFEb2AViYYA/b5iPVrg6V7fk5hPnFeXDJY8a/pjtB3ygbNqckBgrRGmP3s3RiUMWWm2455lEumoahlCtBo4w139uShYGIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=VtbfgnNd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98FC7C2BD10;
	Thu,  4 Jul 2024 01:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1720056397;
	bh=GkVtuwbf8p9cXqHz8uwyctRlpGOGEOw/zHNi1c8dusk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VtbfgnNdZDSCB5aHAmA8l+IM6HQpjrVzZPWmlGsvPIqfnIBX+jX5FbKrW1ueHrsOc
	 Jvc1sP3exmZH54HGbaJ3ZfunTTrhL4f8I+CatAa/LBYuzvVfaBnm9dOdVsaQbzK6ux
	 kNwNd6PKtn/jinxGLUgeUKw2BXkzl6KmJNx9DOtU=
Date: Wed, 3 Jul 2024 18:26:36 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: SeongJae Park <sj@kernel.org>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, "Liam R . Howlett"
 <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, Matthew Wilcox
 <willy@infradead.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Christian
 Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Eric Biederman
 <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>, Suren Baghdasaryan
 <surenb@google.com>, Shuah Khan <shuah@kernel.org>, Brendan Higgins
 <brendanhiggins@google.com>, David Gow <davidgow@google.com>, Rae Moar
 <rmoar@google.com>
Subject: Re: [PATCH 0/7] Make core VMA operations internal and testable
Message-Id: <20240703182636.a04510e21e53b5afe82e60d9@linux-foundation.org>
In-Reply-To: <1edfc11c-ab99-4e9d-bf5d-b10f34b3f1da@lucifer.local>
References: <1a41caa5-561e-415f-85f3-01b52b233506@lucifer.local>
	<20240703225636.90190-1-sj@kernel.org>
	<1edfc11c-ab99-4e9d-bf5d-b10f34b3f1da@lucifer.local>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 4 Jul 2024 00:24:15 +0100 Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:

> The self tests differ from this and other tests using the userland-stubbed
> kernel approach in that they test system call invocation and assert
> expectations.
> 
> My point to Andrew was that we could potentially automatically run these
> tests as part of a self-test run as they are so quick, at least in the
> future, if that made sense.

Yes, I was thinking we'd just add a selftest which does (simplified,
of course)

	cd ../../vma
	make
	./whatever

simply to cause this new code to be invoked when someone runs the
selftest suite.


