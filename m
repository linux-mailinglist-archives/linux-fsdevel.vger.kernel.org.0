Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A05A1E37AC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 May 2020 07:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbgE0FIb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 May 2020 01:08:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbgE0FIa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 May 2020 01:08:30 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B56DFC061A0F;
        Tue, 26 May 2020 22:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XC2Shs5lNCGSRyWc4oHtMietNdOJX+rOUehgxOJwmi0=; b=ka1XYDa8ifbdK426quZ1uqtWdj
        Zi6vV97cDDIL4upmEch9K8LFoJFKV5fINg4EjpgJK0nqDSxSMk1q2rQtAwwC1uQIbiEzqnDI1z9Cn
        qEFFnSP4My9HuxZ90+W9+Q5V2Ri5QzD6F9qSMSRE/UM5R1zqo4L7vgQvNEHf1XIc6MAcpysCeMmmN
        agyuFe2MwhAFEbJx8U3BoE95NXZp/zvGVtGl1XPcjTZsfPtghEzMBhWgW+AcUXfATsY8Fu8NKiFh5
        WU+KGw6JXidH38HMCImS3JbCxELvaKn/gwaFvoUHEs1G6en5TmZBTSHrHa+RPIgF6QgjFyggFuB4g
        FKtMtTfw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jdoIh-0008P7-UA; Wed, 27 May 2020 05:08:23 +0000
Date:   Tue, 26 May 2020 22:08:23 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     KP Singh <kpsingh@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        bpf@vger.kernel.org, linux-security-module@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Martin KaFai Lau <kafai@fb.com>,
        Florent Revest <revest@chromium.org>
Subject: Re: [PATCH bpf-next 2/4] bpf: Implement bpf_local_storage for inodes
Message-ID: <20200527050823.GA31860@infradead.org>
References: <20200526163336.63653-1-kpsingh@chromium.org>
 <20200526163336.63653-3-kpsingh@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200526163336.63653-3-kpsingh@chromium.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 26, 2020 at 06:33:34PM +0200, KP Singh wrote:
> From: KP Singh <kpsingh@google.com>
> 
> Similar to bpf_local_storage for sockets, add local storage for inodes.
> The life-cycle of storage is managed with the life-cycle of the inode.
> i.e. the storage is destroyed along with the owning inode.
> 
> Since, the intention is to use this in LSM programs, the destruction is
> done after security_inode_free in __destroy_inode.

NAK onbloating the inode structure.  Please find an out of line way
to store your information.
