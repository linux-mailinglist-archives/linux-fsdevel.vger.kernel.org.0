Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E952624370F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Aug 2020 11:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbgHMJBl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Aug 2020 05:01:41 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13]:49545 "EHLO
        lizzy.crudebyte.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726131AbgHMJBl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Aug 2020 05:01:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crudebyte.com; s=lizzy; h=Content-Type:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        Content-ID:Content-Description;
        bh=xoEU/e+t3YPzZhroZXeZdFynEC84Ts4q65Sao1+LTas=; b=XLEZSsXO4be6wRTPpunR4waBQx
        qkkew2+Flofmq8uLdJ1kYjYg65q1Fiw2fXiHE4oqI1oDX3QDxLKOSft6+zhxlxbG+zpMRKM2xcUwR
        BT5BZBf1Mim9lAh8ZFtT4STmw6afx461okxIPhGRNk9neWL9nzBAXFi7kbbScDUKnmtG7+ivvQfJJ
        JFigffrLRBKBZHdg97dsIjAilcJiu1JMVAM4q8MemWoHjnlwXEfExRsYMovcfZRleMhHCTOzjyc9Q
        /wZJOQnKqDWb4AaRppdNLCBirIMpwBzpo03SsVZpPG8IotFXhPTh+foEFXhov8BSdEQA4nPPFrSG2
        ah1vlBvw==;
From:   Christian Schoenebeck <qemu_oss@crudebyte.com>
To:     "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc:     Greg Kurz <groug@kaod.org>, linux-fsdevel@vger.kernel.org,
        stefanha@redhat.com, mszeredi@redhat.com, vgoyal@redhat.com,
        gscrivan@redhat.com, dwalsh@redhat.com, chirantan@chromium.org
Subject: Re: xattr names for unprivileged stacking?
Date:   Thu, 13 Aug 2020 11:01:36 +0200
Message-ID: <27541158.PQPtYaGs59@silver>
In-Reply-To: <20200812143323.GF2810@work-vm>
References: <20200728105503.GE2699@work-vm> <12480108.dgM6XvcGr8@silver> <20200812143323.GF2810@work-vm>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mittwoch, 12. August 2020 16:33:23 CEST Dr. David Alan Gilbert wrote:
> > On macOS there was (or actually still is) even a quite complex API which
> > separated forks into "resource forks" and "data forks", where resource
> > forks were typically used as components of an application binary (e.g.
> > menu structure, icons, executable binary modules, text and translations).
> > So resource forks not only had names, they also had predefined 16-bit
> > type identifiers:
> > https://en.wikipedia.org/wiki/Resource_fork
> 
> Yeh, lots of different ways.
> 
> In a way, if you had a way to drop the 64kiB limit on xattr, then you
> could have one type of object, but then add new ways of accessing them
> as forks.

That's yet another question: should xattrs and forks share the same data- and 
namespace, or rather be orthogonal to each other.

Say forks would (one day) have their own ownership and permissions, then 
restricted environments would want to project forks' permissions onto xattrs, 
which would suggest an orthogonal approach (i.e. forks having their own 
xattrs).

OTOH a shared namespace would allow a mellow transition for heterogenous 
systems and their apps from in-memory-only xattrs towards I/O based forks.

Another option: shared namespace, but allowing forks having subforks. That 
would e.g. allow restricted environments to project permissions onto subforks, 
and the latter in turn being accessible by xattr API at the same time.

Or yet another option: shared data space, but nesting the namespace of one 
side under prefix on the other side (e.g. fork "foo" <=> xattr "fork.foo").

Best regards,
Christian Schoenebeck


