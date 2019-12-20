Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F3FA1281F9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2019 19:14:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727400AbfLTSON (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Dec 2019 13:14:13 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:41502 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727391AbfLTSON (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Dec 2019 13:14:13 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iiMmx-0003Dr-Gk; Fri, 20 Dec 2019 18:14:11 +0000
Date:   Fri, 20 Dec 2019 18:14:11 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Eric Sandeen <sandeen@sandeen.net>
Cc:     fsdevel <linux-fsdevel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>
Subject: Re: [PATCH V2] fs_parser: remove fs_parameter_description name field
Message-ID: <20191220181411.GA25833@ZenIV.linux.org.uk>
References: <22be7526-d9da-5309-22a8-3405ed1c0842@sandeen.net>
 <20191218033606.GF4203@ZenIV.linux.org.uk>
 <c83d12e2-59a1-7f35-0544-150515db9434@sandeen.net>
 <20191218040651.GH4203@ZenIV.linux.org.uk>
 <20191219232951.GL4203@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191219232951.GL4203@ZenIV.linux.org.uk>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 19, 2019 at 11:29:51PM +0000, Al Viro wrote:

> I wonder if we should do the following:
> 	* structure with two members - pointer to fc_log and a string
> (prefix) embedded into fs_context, in place of ->log.
> 	* __logfc() taking pointer to that struct, integer or
> character representing the "log level", then format and vararg part.
> 	* warnf() being simply __logfc(&fc->log, 'w', fmt, ## __VA_ARGS__)
> 	* __logfc() using "%c %s%s%pV",
> 				loglevel,
> 				prefix?prefix:"",
> 				prefix ? ":" : "",
> 				fmt, va
> for kvasprintf() (assuming that %pV *can* be used with it, of course)
> 	* const char *set_log_prefix(pointer, string) replacing the
> prefix field of the struct and returning the original.  fs_context
> allocation would set it to fs_type->name.
> 	* __fs_parse() would be taking a pointer to that field of
> fs_context instead of the entire thing; ditto for fs_param_is_...()
> 	* rbd would create a local structure with "rbd" for prefix
> and NULL for log
> 	* net/ceph would replace the prefix in the thing it has
> been given with "libceph" and revert back to original in the end
> 
> The most worrying part in that is kvasprintf interplay with %pV -
> we might need to open-code it, since we need va_copy() not of that
> sucker's arguments, but of the va_list one level deeper.

We won't - va_format() itself does take a copy.  So no open-coding
is needed, kasprint() would work.  OK, that simplifies things...
