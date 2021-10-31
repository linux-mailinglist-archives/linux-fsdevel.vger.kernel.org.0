Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5656440DDE
	for <lists+linux-fsdevel@lfdr.de>; Sun, 31 Oct 2021 11:50:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbhJaKwg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 31 Oct 2021 06:52:36 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:46804 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229638AbhJaKwg (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 31 Oct 2021 06:52:36 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 5789E1F953;
        Sun, 31 Oct 2021 10:50:04 +0000 (UTC)
Date:   Sun, 31 Oct 2021 10:50:04 +0000
From:   Eric Wong <e@80x24.org>
To:     Sargun Dhillon <sargun@sargun.me>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        willy@infradead.org, arnd@kernel.org,
        Willem de Bruijn <willemb@google.com>
Subject: Re: epoll may leak events on dup
Message-ID: <20211031105004.GA12092@dcvr>
References: <20211030100319.GA11526@ircssh-3.c.rugged-nimbus-611.internal>
 <20211031073923.M174137@dcvr>
 <20211031095355.GA15963@ircssh-3.c.rugged-nimbus-611.internal>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211031095355.GA15963@ircssh-3.c.rugged-nimbus-611.internal>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Sargun Dhillon <sargun@sargun.me> wrote:
> On Sun, Oct 31, 2021 at 07:39:23AM +0000, Eric Wong wrote:
> > CRIU?  Checkpoint/Restore In Userspace?
> > Sargun Dhillon <sargun@sargun.me> wrote:
> > 
> Right, in CRIU, epoll is restored by manually cloning the FDs to the
> right spot, and re-installing the events into epoll. This requires:
> 0. Getting the original epoll FD
> 1. Fetching / recreating the original FD
> 2. dup2'ing it to right spot (and avoiding overwriting the original epoll FD)
> 3. EPOLL_CTL_ADD'ing the FD back in.

OK, am I understanding it's something like:

	int tmp_fd = epoll_create1(...);
	if (tmp_fd != orig_epfd) {
		dup2(tmp_fd, orig_epfd);
		close(tmp_fd);
	}

	for (/* loop over original FDs: */) {
		tmp_fd = socket(...);
		if (tmpfd != orig_sfd) {
			dup2(tmp_fd, orig_sfd);
			close(tmp_fd);
		}
		epoll_ctl(orig_epfd, EPOLL_CTL_ADD, orig_sfd, ...);
	}

Is that close to what CRIU is doing?
In no place does tmp_fd end up in the epoll rbtree, there.
Everything is keyed w/ orig_sfd and it's underlying file.
