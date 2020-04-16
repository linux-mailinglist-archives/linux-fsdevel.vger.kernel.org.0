Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 973D41ABA55
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Apr 2020 09:54:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439767AbgDPHv4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Apr 2020 03:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2439759AbgDPHvx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Apr 2020 03:51:53 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38291C0610D5
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Apr 2020 00:51:53 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: rcn)
        with ESMTPSA id 35CD82A0647
Date:   Thu, 16 Apr 2020 09:51:46 +0200
From:   Ricardo =?utf-8?Q?Ca=C3=B1uelo?= <ricardo.canuelo@collabora.com>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     linux-fsdevel@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCH] Implement utf8 unit tests as a kunit test suite.
Message-ID: <20200416075146.zo5bcx5eoatbdgvx@rcn-XPS-13-9360>
References: <20200415082826.19325-1-ricardo.canuelo@collabora.com>
 <851rood23s.fsf@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <851rood23s.fsf@collabora.com>
User-Agent: NeoMutt/20171215
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Gabriel,

Thanks for the comments. I agree with all the style and typo fixes (sorry about
that stray "ext4" mention, I copied the help message from the ext4 kunit config
option and I didn't notice that).

On mié 15-04-2020 14:40:23, Gabriel Krisman Bertazi wrote:
> Instead of this random len and the snprintf to generate the string at
> runtime, why not just:
> 
> #define LATEST_VERSION_STR "12.1.0"
> 
> And use it directly, since it is constant.

I don't think it's a good idea to have the version specifier hardcoded twice in
the same file, one in string form (for utf8_load) and another one in integer
form (for the rest of the functions that take the version as a parameter). I
think it'd be a better option to use a macro to stringify the version number
from the integer constants and avoid the snprintf entirely:

#define str(s) #s
#define VERSION_STR(maj, min, rev) str(maj) "." str(min) "." str(rev)

...

table = utf8_load(VERSION_STR(latest_maj, latest_min, latest_rev));


This way we can define the version constant only once, in integer form, and
then the string form will be a constant generated at compile time. Are you ok
with this?

Cheers,
Ricardo
