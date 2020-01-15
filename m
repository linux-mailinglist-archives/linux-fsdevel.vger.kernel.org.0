Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7B5413B661
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2020 01:09:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728901AbgAOAJH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jan 2020 19:09:07 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:47660 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728759AbgAOAJH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jan 2020 19:09:07 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1irWF7-008Oiq-4g; Wed, 15 Jan 2020 00:09:05 +0000
Date:   Wed, 15 Jan 2020 00:09:05 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: dcache: abstract take_name_snapshot() interface
Message-ID: <20200115000905.GE8904@ZenIV.linux.org.uk>
References: <20200114154034.30999-1-amir73il@gmail.com>
 <20200114162234.GZ8904@ZenIV.linux.org.uk>
 <CAOQ4uxjbRzuAPHbgyW+uGmamc=fZ=eT_p4wCSb0QT7edtUqu8Q@mail.gmail.com>
 <20200114191907.GC8904@ZenIV.linux.org.uk>
 <CAOQ4uxh-1cUQtWoNR+JzR0fCo-yEC4UrQGcZvKyj6Pg11G7FRQ@mail.gmail.com>
 <CAOQ4uxggg4p6MD2LiAKr2dzj+35iA-B3BptXPpOjWMEUX=QbeA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxggg4p6MD2LiAKr2dzj+35iA-B3BptXPpOjWMEUX=QbeA@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 15, 2020 at 02:03:35AM +0200, Amir Goldstein wrote:

> Only problem I forgot about is that I need to propagate name_snapshot
> into fsnotify_move() instead of qstr (in order to snapshot it).
> That means I will need to snapshot also new_dentry in vfs_rename(), so
> I have a name_snapshot to pass into the RENAME_EXCHANGE
> fsnotify_move() hook.
> 
> My current patch passes the cute &old_dentry->d_name_snap abstract
> to fsnotify_move().
> 
> What shall I do about that?
> 
>         take_dentry_name_snapshot(&new_name, new_dentry);
> ???

Wait a sec...  How long is that thing going to be using the snapshot?
And I bloody well hope that this is _not_ going to be unconditional -
having each rename() pay for *notify is a bad idea, for obvious
reasons.  Details, please...
