Return-Path: <linux-fsdevel+bounces-59384-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20DECB38508
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 16:32:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 548061695BF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 14:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E6911B4224;
	Wed, 27 Aug 2025 14:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="M7a2nhQo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370FF18C011
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 Aug 2025 14:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756305131; cv=none; b=RTm7EnkeNIdbzwpHLnykRFbb1z9zOdXIbaj6R08mg0FCfmwXQNNGZ7eD8CpWenndt6QrNdhlXl2ebjVzXuM6rL3k+uitmVeB21IvMSneJoy4jjSSInuDZrzcATFX2DffOJRuxNlwo7nHmBaRqAse7tFCMiZEXEmlYwI4iNAOHyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756305131; c=relaxed/simple;
	bh=PjW5u2C4oIHFPGUUbul58it83dJlsOPZCpSMDE4NdEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BrAdehcoqXwdCmoVMjSuQVHYtZXIw3/Y47ooitut1/H3PQy3l/L2zjwF4KiubJkMf2oTZ1256MYX6/BOIJND1ROipzzmTXQAZZ5SLz8bBaPhVgPxX/Up8tVzV1Elj860xZIATrkdW0oUCu1kmNL9XCsXblJaJVkKHlwV0mICwSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=M7a2nhQo; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-119-253.bstnma.fios.verizon.net [173.48.119.253])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 57REVa5n031440
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Aug 2025 10:31:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1756305100; bh=leSVJr87AJLkI6gqe4SbWcGd4Z7szfWPhzpgcxxKdYA=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=M7a2nhQoTM73TSeCuyWOH01HifuSPIANS641VQRcaJEXq8avfPcK3E61AtR1QSWD5
	 WovfGqa/IweTG8Bk96sVIMyRXgAfr+VOndPuYVAk9IjXrRgOrOBJWHzYuAcURU5uAj
	 hjESpjq43WVZKgaIhCQRaN6LFFgHTmram8UUnSEi01a6IvZGjB55xlf0WtDYPwymSj
	 cfuWyRfpfhuNo6Gm7Se8Wq6NrDFtGlKESaWZur0Oy5aGkSS7eGKetUqDxGadAKdH7z
	 fGzJXxhZd+9Q1h8DDOVQ7Qgq6c3GopVbmDM4od/dhF2AU9HUJarpPU18zbNH7SB+JO
	 qT4djdLwtCwiA==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id C1F112E00D6; Wed, 27 Aug 2025 10:31:36 -0400 (EDT)
Date: Wed, 27 Aug 2025 10:31:36 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: Rajeev Mishra <rajeevm@hpe.com>, linux-block@vger.kernel.org,
        Linux Filesystem Development List <linux-fsdevel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [REGRESSION] loop: use vfs_getattr_nosec for accurate file size
Message-ID: <20250827143136.GA2462272@mit.edu>
References: <20250827025939.GA2209224@mit.edu>
 <274c312c-d0e5-10af-0ef0-bab92e71eb64@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <274c312c-d0e5-10af-0ef0-bab92e71eb64@huaweicloud.com>

On Wed, Aug 27, 2025 at 11:13:13AM +0800, Yu Kuai wrote:
> This is fixed by:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/commit/?h=block-6.17&id=d14469ed7c00314fe8957b2841bda329e4eaf4ab

Great, thanks!  Looking forward to this landing in linux-next (since
it showed up in my automated linux-next testing laght night).

Thanks,

						- Ted

