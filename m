Return-Path: <linux-fsdevel+bounces-20759-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FF998D792F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 01:41:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A4DD1F21DAC
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Jun 2024 23:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93AA97E588;
	Sun,  2 Jun 2024 23:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="b9Zto2ql"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12397E0F0;
	Sun,  2 Jun 2024 23:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717371653; cv=none; b=OLMU8QVtOX95L51pL8xXuzSSfKFbCAn0z2U35fxpaBPAR46DD1PmEb5Y4nno8MZHkAaFjCTOrDFVtJmEdVvnD6veLrESjg2hKgLmTAqpvEkmCTMU10azLSrFZIIkoJS69LCn1cdKFRuiZ0bytOoUjTOerT4OYKG7EAA21CHsNy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717371653; c=relaxed/simple;
	bh=wciVkNuwhwY4OTo/xulZWhg3SFEd/UWQ6aVQlAMFztI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=OQhXhDBcqt7zbx+krykd43r6tlADoz90DUlM+LQTKeNsa+pYk1QmKsAb/EU+c5O3N2TrAZnz8vhxRhSkhOqlMUHHhNZ/iFy4G1ZOMiZTyWCWd7v8Y3KFRswAI4ppmw7bLe548RrQ8yhpeyFe0MB9zapDFf3mId7Hw3EXVTermFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=b9Zto2ql; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=QeKeMAaWVODrDwUwn91S5aAuc1MqdQB3qKAhmDsvwh8=; b=b9Zto2qlZQfegPbM823SALknHO
	ySFQQDuzGSu5qpWoc08sOLuSyfMqvBNAIyXIQPTn6t+gs8fgGioC/Q791XvGOjEJlaDp9NvPv26a/
	ogBBqNLZ4T9KsHMy/w6cLhU9E9EXJyI6qE7naUTmJTbHVhtEZCz5iri3pXRznmwzhgCTCcZ0b9W5q
	uOOhEoe6gvbQRIqeEG7Z/CAj99JH5Rb9+fbiUTImp3lMvUh+TOMyFf8luS55Xwrx56f+XzUklNr2O
	cU4FJ2h6PVo/PaRUECUNtypdpBXetGzeul+tDpETZgQGlkQZcrRl++cbpyTOflrseKWeTffPjc85Q
	iEL/coCw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1sDuoi-00B7rQ-2e;
	Sun, 02 Jun 2024 23:40:48 +0000
Date: Mon, 3 Jun 2024 00:40:48 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, bpf@vger.kernel.org
Subject: [RFC] misuse of descriptor tables in HID-BPF
Message-ID: <20240602234048.GF1629371@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>

static int hid_bpf_insert_prog(int prog_fd, struct bpf_prog *prog)
{
        int i, index = -1, map_fd = -1, err = -EINVAL;

        /* retrieve a fd of our prog_array map in BPF */
        map_fd = skel_map_get_fd_by_id(jmp_table.map->id);

	...

        /* insert the program in the jump table */
        err = skel_map_update_elem(map_fd, &index, &prog_fd, 0);
        if (err)
                goto out;

	...

        if (err < 0)
                __hid_bpf_do_release_prog(map_fd, index);
        if (map_fd >= 0)
                close_fd(map_fd);
        return err;
}

What.  The.  Hell?

Folks, descriptor table is a shared object.  It is NOT safe to use
as a scratchpad.

Another thread might do whatever it bloody wants to anything inserted
there.  It may close your descriptor, it may replace it with something
entirely unrelated to what you've placed there, etc.

This is fundamentally broken.  The same goes for anything that tries
to play similar games.  Don't use descriptor tables that way.

Kernel-side descriptors should be used only for marshalling - they can
be passed by userland (and should be resolved to struct file *, with
no expectations that repeated call of fget() would yield the same
pointer) and they can be returned _to_ userland - after you've allocated
them and associated them with struct file *.

Using them as handles for internal objects is an equivalent of playing
in the traffic - think of it as evolution in action.

