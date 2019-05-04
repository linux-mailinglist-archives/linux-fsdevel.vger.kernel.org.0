Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 68F6513A03
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 May 2019 15:20:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727174AbfEDNUL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 4 May 2019 09:20:11 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:55990 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726781AbfEDNUK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 4 May 2019 09:20:10 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hMuaG-0006ra-Hp; Sat, 04 May 2019 13:20:08 +0000
Date:   Sat, 4 May 2019 14:20:08 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Carmeli Tamir <carmeli.tamir@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] Use list.h instead of file_system_type next
Message-ID: <20190504132008.GY23075@ZenIV.linux.org.uk>
References: <20190504094549.10021-1-carmeli.tamir@gmail.com>
 <20190504094549.10021-2-carmeli.tamir@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190504094549.10021-2-carmeli.tamir@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, May 04, 2019 at 05:45:48AM -0400, Carmeli Tamir wrote:
> From: Tamir <carmeli.tamir@gmail.com>
> 
> Changed file_system_type next field to list_head and refactored
> the code to use list.h functions.

... except that list_head is not a good match here.  For one thing,
we never walk that thing backwards.  For another, filesystem
can be used without ever going through register_filesystem(),
making your data structure quite a mess - e.g. use of list_empty()
(a perfectly normal list.h primitive) on it might oops on some
instances.

IOW, what you are making is not quite list_head and pretending it
to be list_head is asking for serious headache down the road.

Frankly, what's the point?  Reusing an existing data type, to
avoid DIY is generally a good advice, but then you'd better
make sure that existing type *does* fit your needs and that
your creation is playing by that type's rules.

This patch does neither...

NAKed-by: Al Viro <viro@zeniv.linux.org.uk>
