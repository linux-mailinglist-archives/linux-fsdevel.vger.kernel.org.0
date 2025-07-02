Return-Path: <linux-fsdevel+bounces-53728-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6071EAF63DB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 23:22:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA9E91C44163
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 21:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC3E3239E9A;
	Wed,  2 Jul 2025 21:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="FbEPUvrF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7192DE6FA
	for <linux-fsdevel@vger.kernel.org>; Wed,  2 Jul 2025 21:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751491329; cv=none; b=imLIB2BHMQnU35SHhRiaDPddbcMaYMe6JiwAnhd199kmKIUYkiBhVaY/DoRlD5T+qXXCdWEDWqnjNMBcrltxQNQ7RmuJmNgCioH6CVqqKH0pDBtpJ92Jf6go2xtMJHxWHbrpkolm0uXQxF0eJIRUE+2X5m9ppg7Ig3rFxtqDlWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751491329; c=relaxed/simple;
	bh=qi3aN4AMHrC+ZtpBjB9p33nO4D+79Ya/IvKATAJIiTg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RI1oQfs7OAqkTIN+epd0fjFatY0McupLanoyYgPeil25079nWKJSadXTkWmUqhk7Kc6mVAMJedMuQJHu4tVYcjAfH4relWvEeHRrIsq+FJGmR4hMbissqdMe4HPixcTLHbFncRyeZ0jZZUl8Uz0J0aPvRh5pMiopf2e+RXHbOWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=FbEPUvrF; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=hSM+1S7iY+NCy3VYQAkico90ip30lc5TwRGI02ph5/k=; b=FbEPUvrF8a6dnye/QcA9U0botz
	IWIgh90Pi8gwjW1BMSmQpKLFcD2Wf2XygXssr828gwgUfxYDR5ivvP8m2Q90+BON14Vtg8IVMsteZ
	cEbbr/PqWGqfPaug/IFSpSbSCaErBpPA9ASBKOj9hw6vLYjHvTRsg1s1JVWszaMy/DCEtq3etRimM
	vzRJ5PQaYk7zYrRCQcvLzyTGCIdPRUeT4yfjE2lw3rZHy5PdT+VtmQfw3FYnfWnf42VEnG5spq4FU
	spGAQGI0OhnsxWx98O5t4G/ko4iCXjF3c0XB3gBaK2gPZkUtaA7lGdTOiKfU5aDpWztCiVm2f0lCo
	MdCs7Abw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uX4u5-0000000EMRk-365t;
	Wed, 02 Jul 2025 21:22:05 +0000
Date: Wed, 2 Jul 2025 22:22:05 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-fsdevel@vger.kernel.org, Louis Peens <louis.peens@corigine.com>
Subject: [PATCH 06/11] netronome: don't bother with debugfs_real_fops()
Message-ID: <20250702212205.GF3406663@ZenIV>
References: <20250702211305.GE1880847@ZenIV>
 <20250702211408.GA3406663@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250702211408.GA3406663@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

Just turn nfp_tx_q_show() into a wrapper for helper that gets
told whether it's tx or xdp via an explicit argument and have
nfp_xdp_q_show() call the underlying helper instead.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 .../net/ethernet/netronome/nfp/nfp_net_debugfs.c  | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/netronome/nfp/nfp_net_debugfs.c b/drivers/net/ethernet/netronome/nfp/nfp_net_debugfs.c
index d8b735ccf899..d843d1e19715 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_net_debugfs.c
+++ b/drivers/net/ethernet/netronome/nfp/nfp_net_debugfs.c
@@ -77,7 +77,7 @@ DEFINE_SHOW_ATTRIBUTE(nfp_rx_q);
 static int nfp_tx_q_show(struct seq_file *file, void *data);
 DEFINE_SHOW_ATTRIBUTE(nfp_tx_q);
 
-static int nfp_tx_q_show(struct seq_file *file, void *data)
+static int __nfp_tx_q_show(struct seq_file *file, void *data, bool is_xdp)
 {
 	struct nfp_net_r_vector *r_vec = file->private;
 	struct nfp_net_tx_ring *tx_ring;
@@ -86,10 +86,10 @@ static int nfp_tx_q_show(struct seq_file *file, void *data)
 
 	rtnl_lock();
 
-	if (debugfs_real_fops(file->file) == &nfp_tx_q_fops)
-		tx_ring = r_vec->tx_ring;
-	else
+	if (is_xdp)
 		tx_ring = r_vec->xdp_ring;
+	else
+		tx_ring = r_vec->tx_ring;
 	if (!r_vec->nfp_net || !tx_ring)
 		goto out;
 	nn = r_vec->nfp_net;
@@ -115,9 +115,14 @@ static int nfp_tx_q_show(struct seq_file *file, void *data)
 	return 0;
 }
 
+static int nfp_tx_q_show(struct seq_file *file, void *data)
+{
+	return __nfp_tx_q_show(file, data, false);
+}
+
 static int nfp_xdp_q_show(struct seq_file *file, void *data)
 {
-	return nfp_tx_q_show(file, data);
+	return __nfp_tx_q_show(file, data, true);
 }
 DEFINE_SHOW_ATTRIBUTE(nfp_xdp_q);
 
-- 
2.39.5


