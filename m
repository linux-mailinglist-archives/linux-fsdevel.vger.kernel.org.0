Return-Path: <linux-fsdevel+bounces-10191-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54BF8848813
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Feb 2024 18:58:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F854286B2D
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Feb 2024 17:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BE29604D4;
	Sat,  3 Feb 2024 17:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="O+nhKXjJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EEED5FEF1
	for <linux-fsdevel@vger.kernel.org>; Sat,  3 Feb 2024 17:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706983052; cv=none; b=AImGqVUqhRwQPM9CH2J6I3JOnjUBmje754ato2q9beKYLd+wdZqnNDEsFe2J5At0xx2t9HdnZb3AOdMYsXrFb6r5drak6Zn+P5rmQq0ei6td4/cUHNEoDQv0Eooh1w7y6gRyuIjnQhBMWfh9Vd7vD8uL1JenEqs+/ekSc6Yb2dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706983052; c=relaxed/simple;
	bh=Bo2J3ROwLIiapJHkN8vsfH6ZeYWG14rE5e/7F0cESvg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sbT+iYJJUdOYPrj5wK1QeNRXLIPcrAI9olIXQ332slf/pUDlrWDNsqx/53r3zqio25Euj+oARH3O95QCCVblerZ8IOeyCUVw/TAV/sgfxRJS73S2p3WoSYu3Qw+FGnp0o4MSo5UZxszpKSRLQ3VDbAZceoboqCtgUGXVsjLlwQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=O+nhKXjJ; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-82-236.bstnma.fios.verizon.net [173.48.82.236])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 413Huov7016901
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 3 Feb 2024 12:56:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1706983013; bh=h4uAO89DSf3RQZMzijlWW9jpjLoIfP0sKI92dPyza8I=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=O+nhKXjJO4bVxPcA0+xDLeYyR/sqs8uuGW+TPaiaVDrNmVE3w+SM6deaXpmr50Ere
	 FpiFxB9itIewMFM95qnTK+S2B6YA1YPY0Ny0klz9GmM26aR1z1E0rFzIEnJYq2H3me
	 /LvNGIvOroh9UQca/+fn73vzUE8pqW7xsVofDlyItFWUjKqOFtzCp7/qubKcSTxewZ
	 dDTTtGkBWmMJ459MV3miwJCllru6eUPdGei58Cmt8l7vRmrSMIG2/be8CKVh1FRrVh
	 /+4szohXgISbQZXvji31sVZbvx0TVPNOTshSxJOoNGaNvu7gjFBJsPJuxauEnr/Y/A
	 Jd5A8VC8RAMlA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 3261415C02FC; Sat,  3 Feb 2024 12:56:50 -0500 (EST)
Date: Sat, 3 Feb 2024 12:56:50 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        adilger.kernel@dilger.ca, jack@suse.cz, ritesh.list@gmail.com,
        hch@infradead.org, djwong@kernel.org, willy@infradead.org,
        zokeefe@google.com, yi.zhang@huawei.com, chengzhihao1@huawei.com,
        yukuai3@huawei.com, wangkefeng.wang@huawei.com
Subject: Re: [PATCH v3 04/26] ext4: add a hole extent entry in cache after
 punch
Message-ID: <20240203175650.GG36616@mit.edu>
References: <20240127015825.1608160-1-yi.zhang@huaweicloud.com>
 <20240127015825.1608160-5-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240127015825.1608160-5-yi.zhang@huaweicloud.com>

On Sat, Jan 27, 2024 at 09:58:03AM +0800, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> In order to cache hole extents in the extent status tree and keep the
> hole length as long as possible, re-add a hole entry to the cache just
> after punching a hole.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> Reviewed-by: Jan Kara <jack@suse.cz>

Thanks, applied.

