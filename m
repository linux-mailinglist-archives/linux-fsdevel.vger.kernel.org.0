Return-Path: <linux-fsdevel+bounces-41697-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E7D0A35502
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Feb 2025 03:48:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C585118913D8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Feb 2025 02:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73F721474A9;
	Fri, 14 Feb 2025 02:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="cl/RCzvr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C742AE68;
	Fri, 14 Feb 2025 02:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739501281; cv=none; b=rLUI0fXnxswMDxANskV3ei+2HEk8I0ev6SDzhiILfPBRRVkly3Z/rk4URqDCqpjfyV6n/WT8uCzxAKAa/rhuWXttIBQeaQg95//I/JCBADJIU43nxuSubFxtxpGU2n4LvWXIegXTzoPuAi+kvuygDVz8ZLKi5dGgp6YONsDsWYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739501281; c=relaxed/simple;
	bh=hJunwUdzMUtE9krZ7Ki9e9hBH4Z7OinxKH2828Iyq2E=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=NpTA0Zch/ItzE1cuI+M8othVvwF4F+llAVwsq0k3Y3S1paw3CS3cQwJ3SgoOH6g3Ju/CXUkOO70IHRHk0LbBo++5lQdz5aHKDEWEhQn1zoQLHB1Bw97odCsMOPdqJgS5rjSc7xRialFhg7civQqINbHGfI1wvHwy8avEIPh3ov0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=cl/RCzvr; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=GKcMR2FAdMjEc9akgdDLgGm6VnGYG7IPVCMp5usphnk=; b=cl/RCzvrhg2TmZOBCO03F7b2hM
	nTcnxv2p4Qvy2f+FXsGJK5kLAKzIw2QIOiPe130HUaqRWvi8dUIKAYGfE8kWIqEis2bW0y3eYrVT6
	XECKeMHilUq+Yz2CkPNXwSwxe1N+9KkzfIV0QSP1GwLk2BOQ1TuEW3yrGawHtGic7XoyXX8f9HslD
	5PWdrkewpJ2XH5e/kJ9PKb0s5dsBnDip5ZwZ7V7HoXyvVfpqGu8SsS/YHOpCn+CmWzdxDaEeppENU
	TcoI56KbmWnttOzG4sfQZD883L5fKGzV52lwUUNDRtMk+R4eVObak8TCZLpff6MPQAQ1MlSSsRtqE
	NygvP0ww==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tilkC-0000000DHuy-1atN;
	Fri, 14 Feb 2025 02:47:56 +0000
Date: Fri, 14 Feb 2025 02:47:56 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: =?iso-8859-1?Q?Lu=EDs?= Henriques <lhenriques@suse.de>
Cc: ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Ilya Dryomov <idryomov@gmail.com>
Subject: [RFC] odd check in ceph_encode_encrypted_dname()
Message-ID: <20250214024756.GY1977892@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>

AFAICS, this

        /* To understand the 240 limit, see CEPH_NOHASH_NAME_MAX comments */
        WARN_ON(elen > 240);
        if ((elen > 0) && (dir != parent)) {
                char tmp_buf[NAME_MAX];

                elen = snprintf(tmp_buf, sizeof(tmp_buf), "_%.*s_%ld",
                                elen, buf, dir->i_ino);
                memcpy(buf, tmp_buf, elen);
        }

could drop the (elen > 0) part of the test.  elen comes from
        elen = ceph_base64_encode(cryptbuf, len, buf);
and that can't return a non-positive unless the second argument is 0 or
above 1G.  The latter is flat-out impossible - right before that call
we have
        /* hash the end if the name is long enough */
        if (len > CEPH_NOHASH_NAME_MAX) {
                u8 hash[SHA256_DIGEST_SIZE];
                u8 *extra = cryptbuf + CEPH_NOHASH_NAME_MAX;

                /*
                 * hash the extra bytes and overwrite crypttext beyond that
                 * point with it
                 */
                sha256(extra, len - CEPH_NOHASH_NAME_MAX, hash);
                memcpy(extra, hash, SHA256_DIGEST_SIZE);
                len = CEPH_NOHASH_NAME_MAX + SHA256_DIGEST_SIZE;
        }
which obviously caps it with CEPH_NOHASH_NAME_MAX + SHA256_DIGEST_SIZE,
i.e. (180 - SHA256_DIGEST_SIZE) + SHA256_DIGEST_SIZE.

The former would have to come from
        if (!fscrypt_fname_encrypted_size(dir, iname.len, NAME_MAX, &len)) {
                elen = -ENAMETOOLONG;
                goto out;
        }
and since fscrypt_fname_encrypted_size() must've returned true, we have
len no less than FSCRYPT_FNAME_MIN_MSG_LEN, i.e. it's 16 or greater.

That stuff went into the tree in dd66df0053ef8 "ceph: add support for encrypted
snapshot names" and as far as I can tell, everything above had been applicable
back then too.

Am I missing something subtle here?  Can elen be non-positive at that point?

