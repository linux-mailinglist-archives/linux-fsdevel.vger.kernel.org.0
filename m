Return-Path: <linux-fsdevel+bounces-24206-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5513093B4DC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jul 2024 18:22:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F039A1F25111
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jul 2024 16:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D16315ECF3;
	Wed, 24 Jul 2024 16:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="pg3VmUUc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1B515ECC0
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jul 2024 16:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721838109; cv=none; b=VQrYa6b1kAcNv03ezZFmN4E5gwOE9Dm8lFLHfpYENRdsKXYYKJ8+cUrVLh+h8letJ4mWnBQ4ssfNqc51RxvkvqxdUb1swk8ql6yypVwwL7izwyFNR9bOUdqKpmTovyA2rvsOD8iHaftz+bW83cmxpG7a1LExZA6QuWHPIkAF6G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721838109; c=relaxed/simple;
	bh=vB9Yae19v7LUa5zWDxNrPhM5ExpUn167kiKlRJHhN/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JoTbaXR58LjJ1bj0veA9NaL8pSi9/BkaseMSxsW1W1evNVv7I61LUEHyzOTcZ4UHIitZOm/WRX8bTiAj3q6jMx3j24abVsPiv1FlFFpRQKFHgIRI2rbT/CKjXZsOK3qbrrRA4CQ+7e5Bcd9xAmLDPdJ2bC5CwIdwAwgSLo+79iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=pg3VmUUc; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-113-198.bstnma.fios.verizon.net [173.48.113.198])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 46OGLWub017898
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jul 2024 12:21:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1721838094; bh=ofF7hcycKI1A3je2myhR7t0W6v1DJnMOehPToQdbRyQ=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=pg3VmUUcM3zAFe/Nj5tA9Qy1lDlgmYnGrjVRjh/xX7yHcndBx7fqWjHenoKbfywT8
	 lUZbx54qpnqRnxYGF3A6F65zmF6zluUocXbvh2NXFYGBfcakvK5Pb5qEobO1aX7Vkj
	 xQjjcoWwWcze4wdM/rfoWfQ8AMSbWUVntpuae4JjaNiCwHtXZslF2p8DRChV76BMJJ
	 LVCR+/uffm6anG/f5HYtqRzCqdB/2pj9higN/B7uRUFWwyIAEHBqS+3UML7z8zhbpl
	 Bt+eLjzJi+gfQj6S9j+VMLL/easDK+EoR5l2rmOrPtgbpOdpq1Du5z1JrajZ+nZikO
	 ojwkAweMguM6A==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id CF2F915C0251; Wed, 24 Jul 2024 12:21:32 -0400 (EDT)
Date: Wed, 24 Jul 2024 12:21:32 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Yuvaraj Ranganathan <yrangana@qti.qualcomm.com>
Cc: "linux-fscrypt@vger.kernel.org" <linux-fscrypt@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Software encryption at fscrypt causing the filesystem access
 unresponsive
Message-ID: <20240724162132.GB131596@mit.edu>
References: <PH0PR02MB731916ECDB6C613665863B6CFFAA2@PH0PR02MB7319.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR02MB731916ECDB6C613665863B6CFFAA2@PH0PR02MB7319.namprd02.prod.outlook.com>

On Wed, Jul 24, 2024 at 02:21:26PM +0000, Yuvaraj Ranganathan wrote:
> Hello developers,
> 
> We are trying to validate a Software file based encryption with
> standard key by disabling Inline encryption and we are observing the
> adb session is hung.  We are not able to access the same filesystem
> at that moment.

The stack trace seems to indicate that the fast_commit feature is
enabled.  That's a relatively new feature; can you replicate the hang
without fast_commit being enabled?

						- Ted

