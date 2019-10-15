Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27D75D8323
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2019 00:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733035AbfJOWDJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Oct 2019 18:03:09 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:40540 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726965AbfJOWDJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Oct 2019 18:03:09 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iKUuJ-0005hq-15; Tue, 15 Oct 2019 22:03:07 +0000
Date:   Tue, 15 Oct 2019 23:03:07 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     "Pavel V. Panteleev" <panteleev_p@mcst.ru>
Cc:     linux-fsdevel@vger.kernel.org
Subject: Re: copy_mount_options() problem
Message-ID: <20191015220307.GA21325@ZenIV.linux.org.uk>
References: <5DA60B3E.5080303@mcst.ru>
 <20191015184034.GN26530@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191015184034.GN26530@ZenIV.linux.org.uk>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 15, 2019 at 07:40:34PM +0100, Al Viro wrote:
> On Tue, Oct 15, 2019 at 09:09:02PM +0300, Pavel V. Panteleev wrote:
> > Hello,
> > 
> > copy_mount_options() checks that data doesn't cross TASK_SIZE boundary. It's
> > not correct. Really it should check USER_DS boudary, because some archs have
> > TASK_SIZE not equal to USER_DS. In this case (USER_DS != TASK_SIZE)
> > exact_copy_from_user() will stop on access_ok() check, if data cross
> > USER_DS, but doesn't cross TASK_SIZE.
> 
> Details of the call chain, please.

FWIW, what I want to do with copy_mount_options() is this:
void *copy_mount_options(const void __user * data)
{
	unsigned offs, size;
	char *copy;

	if (!data)
		return NULL;

	copy = kmalloc(PAGE_SIZE, GFP_KERNEL);
	if (!copy)
		return ERR_PTR(-ENOMEM);

	offs = (unsigned long)data & (PAGE_SIZE - 1);

	if (copy_from_user(copy, data, PAGE_SIZE - offs)) {
		kfree(copy);
		return ERR_PTR(-EFAULT);
	}
	if (offs) {
		if (copy_from_user(copy, data + PAGE_SIZE - offs, offs))
			memset(copy + PAGE_SIZE - offs, 0, offs);
	}
	return copy;
}

which should get rid of any TASK_SIZE references whatsoever, but I really
wonder where have you run into the problem.
