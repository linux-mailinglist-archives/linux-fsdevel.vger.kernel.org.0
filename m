Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EFFC9DEEB0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2019 16:04:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728889AbfJUOEc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Oct 2019 10:04:32 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:48396 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727152AbfJUOEb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Oct 2019 10:04:31 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iMYIK-0004hs-Ug; Mon, 21 Oct 2019 14:04:25 +0000
Date:   Mon, 21 Oct 2019 15:04:24 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     David Howells <dhowells@redhat.com>
Cc:     Nicolas Pitre <nico@fluxnic.net>, Maxime Bizon <mbizon@freebox.fr>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] cramfs: fix usage on non-MTD device
Message-ID: <20191021140424.GU26530@ZenIV.linux.org.uk>
References: <nycvar.YSQ.7.76.1910191518180.1546@knanqh.ubzr>
 <18923.1571665539@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18923.1571665539@warthog.procyon.org.uk>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 21, 2019 at 02:45:39PM +0100, David Howells wrote:
> Nicolas Pitre <nico@fluxnic.net> wrote:
> 
> > From: Maxime Bizon <mbizon@freebox.fr>
> > 
> > When both CONFIG_CRAMFS_MTD and CONFIG_CRAMFS_BLOCKDEV are enabled, if
> > we fail to mount on MTD, we don't try on block device.
> > 
> > Fixes: 74f78fc5ef43 ("vfs: Convert cramfs to use the new mount API")
> > 
> > Signed-off-by: Maxime Bizon <mbizon@freebox.fr>
> > Signed-off-by: Nicolas Pitre <nico@fluxnic.net>
> 
> Acked-by: David Howells <dhowells@redhat.com>

FWIW, the thing that worries me here is the possibility of
side effects on fs_context in case if fill_super fails really
late...  OTOH, cramfs one seems to be safe in that respect.

OK, will apply, but that's fairly brittle and needs to be
documented.  If we *ever* grow non-trivial options parsing
there, that'll be a serious landmine.  If something gets
transferred from fs_context into a superblock, which
fails later in setup and takes that object with it, the
second part (get_tree_bdev()) would be in trouble.
