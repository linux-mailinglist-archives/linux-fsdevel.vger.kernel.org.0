Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD11D3BA0D6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Jul 2021 15:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232446AbhGBNEp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Jul 2021 09:04:45 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:57574 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232250AbhGBNEn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Jul 2021 09:04:43 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 2FB8320560;
        Fri,  2 Jul 2021 13:02:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1625230930; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3d1yKJRwIM3/3JhL7UHi0GBB49k8bfYaL1isHtBjNiU=;
        b=cR4n9AZzeh+F2V6p9n+sHtf+6fHRppgsvSuFgaB5/1EN9C3rwJ3XOd6z1DpCJrTKIlOPuS
        CaU9IXxxODIbUXf/5/LVXXP9ZqW3E9mybx5FqVIjtCgH1L9KguvGIZAMSBgQcpB6HY73CK
        R4V+UTr82OHyU4CnTKxfaYvRvWvaLDc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1625230930;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3d1yKJRwIM3/3JhL7UHi0GBB49k8bfYaL1isHtBjNiU=;
        b=YZNQrLbP7OiucHCEciIGA1VY7OqUhjIgOpRHnyIHA+E7RVUWocP3FCBXTSYYjH4S8FQM1R
        xboihQsmW00MYQDA==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 7EFC411C84;
        Fri,  2 Jul 2021 13:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1625230930; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3d1yKJRwIM3/3JhL7UHi0GBB49k8bfYaL1isHtBjNiU=;
        b=cR4n9AZzeh+F2V6p9n+sHtf+6fHRppgsvSuFgaB5/1EN9C3rwJ3XOd6z1DpCJrTKIlOPuS
        CaU9IXxxODIbUXf/5/LVXXP9ZqW3E9mybx5FqVIjtCgH1L9KguvGIZAMSBgQcpB6HY73CK
        R4V+UTr82OHyU4CnTKxfaYvRvWvaLDc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1625230930;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3d1yKJRwIM3/3JhL7UHi0GBB49k8bfYaL1isHtBjNiU=;
        b=YZNQrLbP7OiucHCEciIGA1VY7OqUhjIgOpRHnyIHA+E7RVUWocP3FCBXTSYYjH4S8FQM1R
        xboihQsmW00MYQDA==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id eBAbHFEO32CzNAAALh3uQQ
        (envelope-from <lhenriques@suse.de>); Fri, 02 Jul 2021 13:02:09 +0000
Received: from localhost (brahms [local])
        by brahms (OpenSMTPD) with ESMTPA id 1d835cb7;
        Fri, 2 Jul 2021 13:02:08 +0000 (UTC)
Date:   Fri, 2 Jul 2021 14:02:08 +0100
From:   Luis Henriques <lhenriques@suse.de>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Olga Kornievskaia <aglo@umich.edu>,
        Petr Vorel <pvorel@suse.cz>, Steve French <sfrench@samba.org>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        kernel test robot <oliver.sang@intel.com>
Subject: Re: [PATCH v12] vfs: fix copy_file_range regression in cross-fs
 copies
Message-ID: <YN8OUJvdRXAuNXSk@suse.de>
References: <20210702090012.28458-1-lhenriques@suse.de>
 <CAOQ4uxhQciJ=r5E2yvM2zafhnBO4nZNVzUfEU9-tj9SAKAYwGg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxhQciJ=r5E2yvM2zafhnBO4nZNVzUfEU9-tj9SAKAYwGg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 02, 2021 at 02:12:29PM +0300, Amir Goldstein wrote:
<snip>
> I guess there was miscommunication
> 
> As Olga wrote, you have to place this short-circuit in
> nfs4_copy_file_range() if you remove it from here.
> It is NOT SAFE to pass zero length to nfs4_copy_file_range().
> 
> I apologize if you inferred from my response that you don't need to
> do that.

Yeah, I totally misread your email.  But yeah I understand the issue and
I'll take a look into that.  Although this will need to go back to my TODO
pile for next week.

> My intention was, not knowing if and when your patch will be picked up,
> (a volunteer to pick it pick never showed up...)

Right, and this brings the question that this has been dragging already
for a while now.  And I feel like I'm approaching my last attempt before
giving up.  If no one is picking this patch there's no point continue
wasting more time with it (mine and all the other people helping with
reviews and testing).

Anyway... I'll try to get back to this during next week.

Cheers,
--
Luís

> I think that nfs client developers should make sure that the zero length
> check is added to nfs code as fail safety, because the semantics
> of the vfs method and the NFS protocol command do not match.
> 
> Thanks,
> Amir.
