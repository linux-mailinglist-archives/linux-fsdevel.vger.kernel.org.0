Return-Path: <linux-fsdevel+bounces-33214-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8DFC9B5922
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Oct 2024 02:29:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EA2A285BCA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Oct 2024 01:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F3D41547FB;
	Wed, 30 Oct 2024 01:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="bopgHmqz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33AF171CD;
	Wed, 30 Oct 2024 01:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730251756; cv=none; b=t49h4jGYXQjcWy7kHvuTBI0TSY/bMledG4plhyWomEyoPvk5O6U6GWZ3wTALWaN9xn70dDJ3NSIw1Lxkd35r9BuIfe5tJJ2pgg4ZDEFxGPu3ovobagqHX5uvYBQ+ht0fnKmsSsID79L8/cTG/Ld+arb4hY9gcwEZ/7uYx5vQRVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730251756; c=relaxed/simple;
	bh=/mbcRi/mDsk7KQzprNAsgLYx1eJqyekh4W+UXNMCY6U=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=jBk7HyBSi360sekgfKvbuSkeupE9Ceiqkvirq3rE7JFG4k4bE7EB8W3jNv99/I2MfMNxX+3hrQPiE5L5SgJ73MaBLni1kyVkQY3ul996KK12P0X2/DzBjaCEk3Bv3aQuIY11IaXXxT5nz4dYM4bWKGjUpEPPt+1nJzAWF2nTrG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=bopgHmqz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9297C4CECD;
	Wed, 30 Oct 2024 01:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1730251755;
	bh=/mbcRi/mDsk7KQzprNAsgLYx1eJqyekh4W+UXNMCY6U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bopgHmqzM+C4j0EAo9ReKH2Oh2sdeLwPy+6RW9G04/QfDBuujceqDGQmkvjE7gt1c
	 efga9nGuNDMqo+/AenelSy8VQ3LVFtUQn02otvZMfbKyBbrbxa/W52YXq3LNioFHB+
	 PgmWu+cFEiMUBi+zb4/VIJoIwhykHTNtC4LR3GzM=
Date: Tue, 29 Oct 2024 18:29:14 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Mirsad Todorovac <mtodorovac69@gmail.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, Jakob Koschel
 <jakobkoschel@gmail.com>, Mike Rapoport <rppt@kernel.org>, David
 Hildenbrand <david@redhat.com>, Oscar Salvador <osalvador@suse.de>,
 "Brian Johannesmeyer" <bjohannesmeyer@gmail.com>, Cristiano Giuffrida
 <c.giuffrida@vu.nl>, "Bos, H.J." <h.j.bos@vu.nl>, Alexey Dobriyan
 <adobriyan@gmail.com>, Yang Li <yang.lee@linux.alibaba.com>, Baoquan He
 <bhe@redhat.com>, Hari Bathini <hbathini@linux.ibm.com>, Yan Zhen
 <yanzhen@vivo.com>
Subject: Re: [PATCH v1 1/1] fs/proc/kcore.c: fix coccinelle reported ERROR
 instances
Message-Id: <20241029182914.9006075cf5844bc8e679f72c@linux-foundation.org>
In-Reply-To: <20241029054651.86356-2-mtodorovac69@gmail.com>
References: <20241029054651.86356-2-mtodorovac69@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 29 Oct 2024 06:46:52 +0100 Mirsad Todorovac <mtodorovac69@gmail.com> wrote:

> Coccinelle complains about the nested reuse of the pointer `iter' with different
> pointer type:
> 
> ./fs/proc/kcore.c:515:26-30: ERROR: invalid reference to the index variable of the iterator on line 499
> ./fs/proc/kcore.c:534:23-27: ERROR: invalid reference to the index variable of the iterator on line 499
> ./fs/proc/kcore.c:550:40-44: ERROR: invalid reference to the index variable of the iterator on line 499
> ./fs/proc/kcore.c:568:27-31: ERROR: invalid reference to the index variable of the iterator on line 499
> ./fs/proc/kcore.c:581:28-32: ERROR: invalid reference to the index variable of the iterator on line 499
> ./fs/proc/kcore.c:599:27-31: ERROR: invalid reference to the index variable of the iterator on line 499
> ./fs/proc/kcore.c:607:38-42: ERROR: invalid reference to the index variable of the iterator on line 499
> ./fs/proc/kcore.c:614:26-30: ERROR: invalid reference to the index variable of the iterator on line 499
> 
> Replacing `struct kcore_list *iter' with `struct kcore_list *tmp' doesn't change the
> scope and the functionality is the same and coccinelle seems happy.

Well that's dumb of it.  Still, the code is presently a bit weird and
we don't mind working around such third-party issues.

> NOTE: There was an issue with using `struct kcore_list *pos' as the nested iterator.
>       The build did not work!

It worked for me.  What's wrong with that?

> --- a/fs/proc/kcore.c
> +++ b/fs/proc/kcore.c
> @@ -493,13 +493,13 @@ static ssize_t read_kcore_iter(struct kiocb *iocb, struct iov_iter *iter)
>  		 * the previous entry, search for a matching entry.
>  		 */
>  		if (!m || start < m->addr || start >= m->addr + m->size) {
> -			struct kcore_list *iter;
> +			struct kcore_list *tmp;

`tmp' is a really poor identifier :(

Let's try `pos':

--- a/fs/proc/kcore.c~fs-proc-kcorec-fix-coccinelle-reported-error-instances-fix
+++ a/fs/proc/kcore.c
@@ -493,13 +493,13 @@ static ssize_t read_kcore_iter(struct ki
 		 * the previous entry, search for a matching entry.
 		 */
 		if (!m || start < m->addr || start >= m->addr + m->size) {
-			struct kcore_list *tmp;
+			struct kcore_list *pos;
 
 			m = NULL;
-			list_for_each_entry(tmp, &kclist_head, list) {
-				if (start >= tmp->addr &&
-				    start < tmp->addr + tmp->size) {
-					m = tmp;
+			list_for_each_entry(pos, &kclist_head, list) {
+				if (start >= pos->addr &&
+				    start < pos->addr + pos->size) {
+					m = pos;
 					break;
 				}
 			}
_


