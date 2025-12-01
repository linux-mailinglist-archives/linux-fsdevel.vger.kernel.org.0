Return-Path: <linux-fsdevel+bounces-70297-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B7EBC96176
	for <lists+linux-fsdevel@lfdr.de>; Mon, 01 Dec 2025 09:19:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3F8374E15BF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Dec 2025 08:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EB452E62A9;
	Mon,  1 Dec 2025 08:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FFkqNecW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9407828851C;
	Mon,  1 Dec 2025 08:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764577191; cv=none; b=bPSIF07AAnd1nBqz3v0jQYgh6QEyS47AI7QFbD72tT4jOZOl6keT0liR3hHTX+uNZO3vysznKa6cHv+TnEbJ5rPBp/hT4XbLHsWgmfXm19WdgvKMtepAMSe5pqztKa4ReUFlaC61nFXWWOzmUKca1Vbe0W2GE3HzYImXdptCU84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764577191; c=relaxed/simple;
	bh=TyDsCpSjVQPKClS1wS8LjD9cMplDLdLnzGgbUD+M79g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hifoWEXqgrqwy5wOXaoseJcmG+hEi9zTnYpBG1XcHutNCLHXKmmgiWXQIaBFnEHjB+7lFnz3rcIaYI6GJ+EXVZQ9jyen18KRP2x6rKBlIKaqJERRpyBKJbV/xIR1sPo3aUuFBiGTSGGg+cflIPb+4eh6mJUqFxuh6c7TFlCFfKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FFkqNecW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E949EC4CEF1;
	Mon,  1 Dec 2025 08:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764577191;
	bh=TyDsCpSjVQPKClS1wS8LjD9cMplDLdLnzGgbUD+M79g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FFkqNecWdOz02hyU/ng9/WjcQu8oIo83JNmAQkIqCVp7AKD4X6xh1SBbruEDCDho1
	 4gbEvSs+qRBcEesTGkhlfApAgY5b68kKV99l6CFPLSQEk2bm2oLaSYoPnXjS2S7F9u
	 9KUKl7XBl27QAU2Lk0BiA7jZ0eK0pAx03BdTUevhqFSaSXQtzRo0ahjMQeA4+1AWnf
	 PPh6QEbdNXxijGAcND0dmuw5xXQLN0JULlzSsYKxlTjMtN3+i83ZQZ2vf0ENRKmg/J
	 7aZB1wREI91gpStkzMXWTOYrrGBKWMTaj+0sFYqFyJwymYyidzlreja6ZeVuuQinok
	 iMN4EcITQOAWw==
Received: by pali.im (Postfix)
	id 0D093700; Mon,  1 Dec 2025 09:19:43 +0100 (CET)
Date: Mon, 1 Dec 2025 09:19:42 +0100
From: Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Namjae Jeon <linkinjeon@kernel.org>, viro@zeniv.linux.org.uk,
	brauner@kernel.org, hch@lst.de, tytso@mit.edu, willy@infradead.org,
	jack@suse.cz, djwong@kernel.org, josef@toxicpanda.com,
	sandeen@sandeen.net, rgoldwyn@suse.com, xiang@kernel.org,
	dsterba@suse.com, ebiggers@kernel.org, neil@brown.name,
	amir73il@gmail.com, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, iamjoonsoo.kim@lge.com,
	cheol.lee@lge.com, jay.sim@lge.com, gunho.lee@lge.com
Subject: Re: [PATCH v2 01/11] ntfsplus: in-memory, on-disk structures and
 headers
Message-ID: <20251201081942.fchmydmpygqk7rzr@pali>
References: <20251127045944.26009-1-linkinjeon@kernel.org>
 <20251127045944.26009-2-linkinjeon@kernel.org>
 <aS1AUP_KpsJsJJ1q@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aS1AUP_KpsJsJJ1q@infradead.org>
User-Agent: NeoMutt/20180716

On Sunday 30 November 2025 23:14:24 Christoph Hellwig wrote:
> On Thu, Nov 27, 2025 at 01:59:34PM +0900, Namjae Jeon wrote:
> > +iocharset=name		Deprecated option.  Still supported but please use
> > +			nls=name in the future.  See description for nls=name.

IMHO this is a bug in documentation. All fs drivers are using iocharset=
option so deprecated should be nls= option and iocharset= should be the
primary non-deprecated one.

