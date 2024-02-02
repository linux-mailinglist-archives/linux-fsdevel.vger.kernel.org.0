Return-Path: <linux-fsdevel+bounces-10041-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C016847428
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 17:08:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBAA21C21FA9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 16:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EBFD14A09B;
	Fri,  2 Feb 2024 16:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="lrSmsY9a"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C296914A090;
	Fri,  2 Feb 2024 16:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706889918; cv=none; b=smUbuvixxghXRV8TGeftk2TyJd4jJgmqju7H8eTJfRcAGkloAUCPL3+S9jopD+4mZ2RxNMTcuUye8aNgoqnpj9rP7OMPFdLrGTtodAQXMxQcQQRSOy0XbfJ5KphGsNC8FUHbhePb9uEGJ4BTCTbPilBvmPVber0p1WS4L9JEXVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706889918; c=relaxed/simple;
	bh=Dk+AdKbujF9yB/76ocqE4KumZbVmual/1iWHKicEDGo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KzOkqew6qHdfGqVPzKdAPKmRV2YBe5yMtP7nctQBUKh/ZRnk5FiElaBIFmeFFVccUHxipfWynh79msp4ufJtU8JMADtf0dnFIsLeunSbZqGd/tuDFIIx4RexSKstuiRBlTDhIJOdWu1SEnQskqP6XzP89R3hz+fBt80ettzdjYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=lrSmsY9a; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=rnRJDh4uEm9M5Ik5O73gj9GsHnJBLKW/Eb0H5ErNkHM=; b=lrSmsY9alYvyue7TNgw6JegiNE
	LX6hhmVwWpcHej3bwYUpvn5hJv+b86gPMDErVYwdqKIPH7CK7kw9sCv6xrEljXUmL8CyQFCU/blHd
	+AfpJuq+UbPufo+ZrYbeOYuG2sIIN4YXBhJK+IA2yd7abnTYyMyOCfQIG6ElH+vKaZLMm4QPBKsNO
	Y6MwNnWChMG/nVIen+TWwrYf7svM5ciALw2y9q8ulaNeAg9chMn57pzfC/AvnHM5DJAgqIGBge84Z
	geAT/qXmBgYx8CI0ffTTX3NkFXiRb3LASZnDnfe0jCeIuZ+E7kOWRh/uTbqbAAXZwS2J7P3Jv7iRY
	vCwVkFwg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rVw2P-0045rA-13;
	Fri, 02 Feb 2024 16:05:09 +0000
Date: Fri, 2 Feb 2024 16:05:09 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>,
	Christian Brauner <brauner@kernel.org>,
	Stefan Berger <stefanb@linux.ibm.com>,
	Mimi Zohar <zohar@linux.ibm.com>, linux-unionfs@vger.kernel.org,
	linux-integrity@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/2] fs: remove the inode argument to ->d_real() method
Message-ID: <20240202160509.GZ2087318@ZenIV>
References: <20240202110132.1584111-1-amir73il@gmail.com>
 <20240202110132.1584111-3-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240202110132.1584111-3-amir73il@gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Feb 02, 2024 at 01:01:32PM +0200, Amir Goldstein wrote:
> The only remaining user of ->d_real() method is d_real_inode(), which
> passed NULL inode argument to get the real data dentry.
> 
> There are no longer any users that call ->d_real() with a non-NULL
> inode argument for getting a detry from a specific underlying layer.
> 
> Remove the inode argument of the method and replace it with an integer
> 'type' argument, to allow callers to request the real metadata dentry
> instead of the real data dentry.
> 
> All the current users of d_real_inode() (e.g. uprobe) continue to get
> the real data inode.  Caller that need to get the real metadata inode
> (e.g. IMA/EVM) can use d_inode(d_real(dentry, D_REAL_METADATA)).

Hmm...  Speaking of the callers, could somebody try explain to IMA
folks that they _still_ have a blatant UAF in ima_collect_measurement()?
I gave up after several attempts years ago...

int ima_collect_measurement(struct integrity_iint_cache *iint,
                            struct file *file, void *buf, loff_t size,
                            enum hash_algo algo, struct modsig *modsig)
{
        const char *audit_cause = "failed";
        struct inode *inode = file_inode(file);
        struct inode *real_inode = d_real_inode(file_dentry(file));
        const char *filename = file->f_path.dentry->d_name.name;

The name is longer than 40 characters, and thus separately allocated.

	...
Somebody renames the file, now the name is short and ->d_name.name points to
embedded array.  The reference to external name is dropped and it's freed
after an RCU delay.
	...
        tmpbuf = krealloc(iint->ima_hash, length, GFP_NOFS);
We block, RCU delay expires and filename points to freed memory object.
	...

                integrity_audit_msg(AUDIT_INTEGRITY_DATA, inode,
                                    filename, "collect_data", audit_cause,
                                    result, 0);

Which calls integrity_audit_message(), where we hit
                audit_log_untrustedstring(ab, fname);
with fname being our dangling pointer.

Use After Free.  Really.  And "untrusted" in the function name does not
refer to "it might be pointing to unmapped page" - it's just "don't
expect anything from the characters you might find there, including
the presence of NUL".

