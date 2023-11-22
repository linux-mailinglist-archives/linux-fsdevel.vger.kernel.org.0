Return-Path: <linux-fsdevel+bounces-3475-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 989E37F51F8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 21:59:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 397ACB20DA5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 20:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A87D61A58F;
	Wed, 22 Nov 2023 20:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="vYv0j7L+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D6D018D;
	Wed, 22 Nov 2023 12:59:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ItOH4J4akSw10+RJtO1Y4ChxcpuLncLMjxNty1VtDU8=; b=vYv0j7L+dcsY2dIfElCy7D8CHt
	BOJR+U78FSLDhQUShbKI0HjkscG/pNujZ4x7UMH070cOT39LfHRCrOotFD6fZ0eyWVxEwogAYDDsD
	AEZgD3hZNDAzHDTqlsHpFVELRHqBA+heb+41vqvYEnJDOm4aCvXXPR2N0rO+sqIHviTxpM0k4QRLw
	F9Mwy9QPGSXEumvsTjJMKepFcV9zHxQXBHFfcxyDHMlcJWti2YMiNpPPxPRAa6jX4epYmOEUFsa6j
	Tea1pPXz4c65Q5G5aBfSs0dBnfl9N/I+qtWOpvtDpG/TkEa9znfwJsgpUZMVRWIMkLBFh9sbve7LD
	1dQDfBVg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r5uJi-001mWY-2Q;
	Wed, 22 Nov 2023 20:59:26 +0000
Date: Wed, 22 Nov 2023 20:59:26 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Gabriel Krisman Bertazi <krisman@suse.de>
Cc: brauner@kernel.org, tytso@mit.edu, ebiggers@kernel.org,
	jaegeuk@kernel.org, linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: Re: [PATCH v6 3/9] fs: Expose name under lookup to d_revalidate hooks
Message-ID: <20231122205926.GH38156@ZenIV>
References: <20230816050803.15660-1-krisman@suse.de>
 <20230816050803.15660-4-krisman@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230816050803.15660-4-krisman@suse.de>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Aug 16, 2023 at 01:07:57AM -0400, Gabriel Krisman Bertazi wrote:
> From: Gabriel Krisman Bertazi <krisman@collabora.com>
> 
> Negative dentries support on case-insensitive ext4/f2fs will require
> access to the name under lookup to ensure it matches the dentry.  This
> adds the information on d_revalidate and updates its implementation.

There's actually one hell of a stronger reason for that particular change;
uses of ->d_name in ->d_revalidate() instances are often racy.

So IMO this is the right way to go, regardless of c-i stuff, except that
it ought to be followed by making individual ->d_revalidate() instances use
the damn argument, now that they have it in stable form.

Said followups don't need to be in the same series, obviously.

