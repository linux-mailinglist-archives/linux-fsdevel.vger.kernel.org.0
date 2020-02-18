Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60A7F163611
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2020 23:25:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbgBRWZx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Feb 2020 17:25:53 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:34288 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbgBRWZx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Feb 2020 17:25:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=U/2UUN028vo81ZrqFUEoPFGx33zKd6NlgQ7akWSaRsA=; b=Nz74xaDHOO7lXfmrBKNYfjZorp
        Q3cR3uFDQ8No1ynd516JVLbMRgSZTOVgPv6n/MLpvD5KweZY4iZQGFcMeaE2ZLpXabJf20nTrNx2c
        dlzBuax4NVqh7D7+oAT/dHmMaeI6YnYTe6tyl4i3U4ErelWwa1m+e8Uv9bm7hATV/FP79EDkhX3qf
        3gKT4aiq0+WhO0vu6glY2Ib+SXQUNEhhskDLu8WZNK+44SXFo00x6jNgOiz9dIY9CmWR/Zcbg4XIE
        hOiAZXWQjbIaKjoy725fglr628cECq3jwTJ8r3vXz+cSVZJG+LlRR9ScKvd045XVqppXd3Mbjhrpt
        I7y9GPKg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j4BIx-0003t7-Rk; Tue, 18 Feb 2020 22:25:23 +0000
Date:   Tue, 18 Feb 2020 14:25:23 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     =?iso-8859-1?Q?St=E9phane?= Graber <stgraber@ubuntu.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Aleksa Sarai <cyphar@cyphar.com>, Jann Horn <jannh@google.com>,
        smbarber@chromium.org, Seth Forshee <seth.forshee@canonical.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Serge Hallyn <serge@hallyn.com>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Phil Estes <estesp@gmail.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        containers@lists.linux-foundation.org,
        linux-security-module@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH v3 11/25] inode: inode_owner_or_capable(): handle fsid
 mappings
Message-ID: <20200218222523.GA9535@infradead.org>
References: <20200218143411.2389182-1-christian.brauner@ubuntu.com>
 <20200218143411.2389182-12-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200218143411.2389182-12-christian.brauner@ubuntu.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 18, 2020 at 03:33:57PM +0100, Christian Brauner wrote:
> +	if (is_userns_visible(inode->i_sb->s_iflags)) {
> +		if (kuid_has_mapping(ns, inode->i_uid) && ns_capable(ns, CAP_FOWNER))
> +			return true;
> +	} else if (kfsuid_has_mapping(ns, inode->i_uid) && ns_capable(ns, CAP_FOWNER)) {

This adds some crazy long unreadable lines..
