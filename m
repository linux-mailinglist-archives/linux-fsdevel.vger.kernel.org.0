Return-Path: <linux-fsdevel+bounces-7993-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 614B782E084
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jan 2024 20:16:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05F92282B39
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jan 2024 19:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9457118C3F;
	Mon, 15 Jan 2024 19:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="iW/4ukvU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58CC51802B;
	Mon, 15 Jan 2024 19:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=+vVnPmy/TAg8RPrrTtiwJI/BlzjY8BbZQ3ahxzEpH8M=; b=iW/4ukvUNBqGT8LfQP2tycMtqI
	BPW2dlI9CdPZy72wJf/8UZ+1/R24ZAwpAi/VgT8F1wC7kKQmkEdOX3/TU2BYtD8oEr3YBhMFe4ZsS
	7ZzBNCSODKnPOXk44h037pmUtdgkrRnLrDUm6zrXVaOUK5xjvc9JLfiBYXzusi7P5H1hXYoIWo6Ao
	9/CxiPBJmjxZ4lZ57EaY25Z5fYYStj1mN0EYL4bkkiTrFXH1Ok3ci9KI4jeT5wNnhuT2ws10yOPnz
	jIFbtYvzQJk5T0aebG4O1f1pyY30J6uJH/m5PbG1WE5sd6EJbSQ0INiqZwyVZfXTLvA7kEUi7CR0e
	agzrQ35g==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rPSQO-003JhU-0B;
	Mon, 15 Jan 2024 19:15:08 +0000
Date: Mon, 15 Jan 2024 19:15:08 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc: brauner@kernel.org, chuck.lever@oracle.com, jlayton@kernel.org,
	neilb@suse.de, kolga@netapp.com, Dai.Ngo@oracle.com, tom@talpey.com,
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
	zohar@linux.ibm.com, dmitry.kasatkin@gmail.com,
	eric.snowberg@oracle.com, dhowells@redhat.com, jarkko@kernel.org,
	stephen.smalley.work@gmail.com, eparis@parisplace.org,
	casey@schaufler-ca.com, shuah@kernel.org, mic@digikod.net,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org, linux-security-module@vger.kernel.org,
	linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
	selinux@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Roberto Sassu <roberto.sassu@huawei.com>
Subject: Re: [PATCH v9 13/25] security: Introduce file_release hook
Message-ID: <20240115191508.GG1674809@ZenIV>
References: <20240115181809.885385-1-roberto.sassu@huaweicloud.com>
 <20240115181809.885385-14-roberto.sassu@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240115181809.885385-14-roberto.sassu@huaweicloud.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Jan 15, 2024 at 07:17:57PM +0100, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
> 
> In preparation for moving IMA and EVM to the LSM infrastructure, introduce
> the file_release hook.
> 
> IMA calculates at file close the new digest of the file content and writes
> it to security.ima, so that appraisal at next file access succeeds.
> 
> An LSM could implement an exclusive access scheme for files, only allowing
> access to files that have no references.

Elaborate that last part, please.

