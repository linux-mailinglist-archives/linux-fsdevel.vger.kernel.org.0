Return-Path: <linux-fsdevel+bounces-38163-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D09DE9FD550
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Dec 2024 15:52:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7313F3A0896
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Dec 2024 14:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30BAD1F5421;
	Fri, 27 Dec 2024 14:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="ZEBzoXFv";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="ZEBzoXFv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D171F472F;
	Fri, 27 Dec 2024 14:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735311126; cv=none; b=XAdZUYRArnf1BKClcoOuYxKWyUkXarBb8LD6+G5o1Tn1jABhDZsDELaqhav/b2AGIcjdEHrKCezBa+eh2DUyMZUnlVzlbLc5MHs7ijQxFSdWIHAZM+CH8ZvUW4TfOz3EbT0J5ATxqT/R/HHJ4CxNV27ubC3IcRP+G4xAKzH2fLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735311126; c=relaxed/simple;
	bh=4z3YmDSKE8+cHYQxs2eBVWKqFExGvMI3m3zmieQ5SOM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZlJC+OeBdEJ8jkhhZSZcBrIqnVTxtk6jLkC0zH6sPxY/HBadc1Q9E4NxL/O8xCCz3UhGeGA+EMS2aOisYCUejOTuxERkZdEzfRjzBitHFUo6/nUbqQTATCU0jezrYJOH/Ojd67H6NbplG9EIe985/GRTNlEVliTA+gRYF58VPRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=ZEBzoXFv; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=ZEBzoXFv; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1735311123;
	bh=4z3YmDSKE8+cHYQxs2eBVWKqFExGvMI3m3zmieQ5SOM=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=ZEBzoXFvS2+Yzu9BVuM/XkoXV6px1kx0ZiaGFwKaoKcXkHYJlSdjRT0QdTmxaycFq
	 DUmYTDsEiEv3R0hxMpBUJzQk1XArkYcNN0XPvWto6UPdPfdmH1i92KfA/zp2KYF8KA
	 TfpgkzS8jM45/9sGiUluWPkpvwzp8vBG8S8IT01w=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id B7B711286A6E;
	Fri, 27 Dec 2024 09:52:03 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id sCThYn8AG4jc; Fri, 27 Dec 2024 09:52:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1735311123;
	bh=4z3YmDSKE8+cHYQxs2eBVWKqFExGvMI3m3zmieQ5SOM=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=ZEBzoXFvS2+Yzu9BVuM/XkoXV6px1kx0ZiaGFwKaoKcXkHYJlSdjRT0QdTmxaycFq
	 DUmYTDsEiEv3R0hxMpBUJzQk1XArkYcNN0XPvWto6UPdPfdmH1i92KfA/zp2KYF8KA
	 TfpgkzS8jM45/9sGiUluWPkpvwzp8vBG8S8IT01w=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::a774])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id E98591286A68;
	Fri, 27 Dec 2024 09:52:02 -0500 (EST)
Message-ID: <062f29e721c4939461bb0b9f482ae9d56c80aed7.camel@HansenPartnership.com>
Subject: Re: [PATCH 6/6] efivarfs: fix error on write to new variable
 leaving remnants
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>, Jeremy Kerr
	 <jk@ozlabs.org>
Date: Fri, 27 Dec 2024 09:52:01 -0500
In-Reply-To: <03f765e9fa9cceeded1a02e12ddec68a0743233f.camel@HansenPartnership.com>
References: <20241210170224.19159-1-James.Bottomley@HansenPartnership.com>
	 <20241210170224.19159-7-James.Bottomley@HansenPartnership.com>
	 <20241211-krabben-tresor-9f9c504e5bd7@brauner>
	 <049209daadc928ecbf3bdb17d80634fa55842263.camel@HansenPartnership.com>
	 <f9690563fe9d7ae4db31dd37650777e02580b332.camel@HansenPartnership.com>
	 <20241223200513.GO1977892@ZenIV>
	 <72a3f304b895084a1da0a8a326690a57fce541b7.camel@HansenPartnership.com>
	 <20241223231218.GQ1977892@ZenIV>
	 <41df6ecc304101b688f4b23040859d6b21ed15d8.camel@HansenPartnership.com>
	 <20241224044414.GR1977892@ZenIV>
	 <25eadec2e46a5f0d452fd1b3d4902f67aeb39360.camel@HansenPartnership.com>
	 <03f765e9fa9cceeded1a02e12ddec68a0743233f.camel@HansenPartnership.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

On Tue, 2024-12-24 at 10:09 -0500, James Bottomley wrote:
> On Tue, 2024-12-24 at 08:07 -0500, James Bottomley wrote:
> [...]
> 
> > On the other hand the most intuitive thing would be to remove zero
> > length files on last close, not first, so if you have a thought on
> > how to do that easily, I'm all ears.
> 
> I could do this by adding an open_count to the i_private data struct
> efivar_entry and reimplementing simple_open as an efivarfs specific
> open that increments this count and decrementing it in ->release(). 
> That's still somewhat adding "more convoluted crap", though ...

There being no other suggestions as to how the vfs might do this; this
is a sketch of the additional code needed to do it within efivarfs.  As
you can see, it's not actually that much.  If this is OK with everyone
I'll fold it in and post a v2.  Since all simple_open really does is
copy i_private to file->private_data, there's really not a lot of
duplication in the attached.

Regards,

James

---

diff --git a/fs/efivarfs/file.c b/fs/efivarfs/file.c
index 0e545c8be173..cf0179d84bc5 100644
--- a/fs/efivarfs/file.c
+++ b/fs/efivarfs/file.c
@@ -121,14 +121,34 @@ static ssize_t efivarfs_file_read(struct file
*file, char __user *userbuf,
 
 static int efivarfs_file_release(struct inode *inode, struct file
*file)
 {
-	if (i_size_read(inode) == 0)
+	bool release;
+	struct efivar_entry *var = inode->i_private;
+
+	inode_lock(inode);
+	release = (--var->open_count == 0 && i_size_read(inode) == 0);
+	inode_unlock(inode);
+
+	if (release)
 		simple_recursive_removal(file->f_path.dentry, NULL);
 
 	return 0;
 }
 
+static int efivarfs_file_open(struct inode *inode, struct file *file)
+{
+	struct efivar_entry *entry = inode->i_private;
+
+	file->private_data = entry;
+
+	inode_lock(inode);
+	entry->open_count++;
+	inode_unlock(inode);
+
+	return 0;
+}
+
 const struct file_operations efivarfs_file_operations = {
-	.open		= simple_open,
+	.open		= efivarfs_file_open,
 	.read		= efivarfs_file_read,
 	.write		= efivarfs_file_write,
 	.release	= efivarfs_file_release,
diff --git a/fs/efivarfs/internal.h b/fs/efivarfs/internal.h
index 18a600f80992..32b83f644798 100644
--- a/fs/efivarfs/internal.h
+++ b/fs/efivarfs/internal.h
@@ -26,6 +26,7 @@ struct efi_variable {
 
 struct efivar_entry {
 	struct efi_variable var;
+	unsigned long open_count;
 };
 
 int efivar_init(int (*func)(efi_char16_t *, efi_guid_t, unsigned long,
void *),



