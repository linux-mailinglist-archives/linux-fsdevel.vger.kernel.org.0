Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19E1551B1D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jun 2019 21:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728956AbfFXTCn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jun 2019 15:02:43 -0400
Received: from hr2.samba.org ([144.76.82.148]:47524 "EHLO hr2.samba.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727912AbfFXTCn (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jun 2019 15:02:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
         s=42627210; h=Message-ID:Cc:To:From:Date;
        bh=sXmv0rmoVJ0UFhnTzdQARYWS7+Af9W+ln3++XJeZKAs=; b=iNYrUYfgQAIWFuayPUnKySmHiw
        YneD7/bY4dVAGsbyNkk8Fn85qG8PTJgo3YYcDdKxkzlTYA8ZzG7p0cM54IsKvNIbG/LdFaKe7oukk
        YEFJx7mrMdFmW/Tar4sdcTklsurJo16/wVZzChdC986WjCgbhukwGYyRRa6J5DJMObpw=;
Received: from [127.0.0.2] (localhost [127.0.0.1])
        by hr2.samba.org with esmtpsa (TLS1.2:ECDHE_ECDSA_CHACHA20_POLY1305:256)
        (Exim)
        id 1hfUEi-0001Rc-KK; Mon, 24 Jun 2019 19:02:41 +0000
Date:   Mon, 24 Jun 2019 12:02:37 -0700
From:   Jeremy Allison <jra@samba.org>
To:     ronnie sahlberg <ronniesahlberg@gmail.com>
Cc:     Steve French <smfrench@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        samba-technical <samba-technical@lists.samba.org>
Subject: Re: xfstest 531 and unlink of open file
Message-ID: <20190624190237.GD3690@jeremy-ThinkPad-X1>
Reply-To: Jeremy Allison <jra@samba.org>
References: <CAH2r5mv+oqGxZRkV_ROqdauNW0CYJ7X9uJCk+uYmercJ4De41w@mail.gmail.com>
 <CAN05THTqP+_uSEPq2FqBEnV8FeuutaHASznH6iBDS=C0hCD=kQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAN05THTqP+_uSEPq2FqBEnV8FeuutaHASznH6iBDS=C0hCD=kQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 24, 2019 at 01:44:53PM +1000, ronnie sahlberg via samba-technical wrote:
> On Mon, Jun 24, 2019 at 1:23 PM Steve French <smfrench@gmail.com> wrote:
> >
> > Xioli created a fairly simple unlink test failure reproducer loosely
> > related to xfstest 531 (see
> > https://bugzilla.kernel.org/show_bug.cgi?id=203271) which unlinks an
> > open file then tries to create a file with the same name before
> > closing the first file (which fails over SMB3/SMB3.11 mounts with
> > STATUS_DELETE_PENDING).
> >
> > Presumably we could work around this by a "silly-rename" trick.
> > During delete we set delete on close for the file, then close it but
> > presumably we could check first if the file is open by another local
> > process and if so try to rename it?
> >
> > Ideas?
> 
> The test is to check "can you unlink and recreate a file while someone
> (else) is holding it open?"
> 
> I don't think you can rename() a file while other folks have it open :-(
> This is likely a place where NTFS is too different from Posix that we
> can't get full 100% posix semantics.

Yeah, this is one of the places you need SMB3+ POSIX extensions
(and even there we fail it if a Windows open exists on the same
handle).
