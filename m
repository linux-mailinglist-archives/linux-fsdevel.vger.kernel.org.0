Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B1A75FE384
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Oct 2022 22:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbiJMUwU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Oct 2022 16:52:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiJMUwR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Oct 2022 16:52:17 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78C14170DE4;
        Thu, 13 Oct 2022 13:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665694334; x=1697230334;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=DS/ZyZcyEjHNaV7o5ku/y817lSJV9cUyzZCnu//ovMA=;
  b=NLr/a+id4l8L5nyPAYrlqKllRge9GcJuHcp8LATLE3AsjiWcVnTcIJsi
   OpWi3kCN0RvnqnTPmk49heV41pzRX+t8I18YRKfy2pBdEDzAmCb4xhqWY
   lvMUPErTJOTP/F9XSlmymii3fpH9GCK1iB4J9wU4hm9RhoBomz08p2TwA
   qlbwBx4c/4zpr695GWl5O6ttw3aZcWkiaQya2gXX9jYXouqkuwAQIk9FU
   2uqqhM8Ip1/1VoyWGTLy6xkVD75XRu8VfvFlYiNXPLVTLYSuV9A5H24PA
   kipAdOjFr6lXIofOs9kSTRUDw2SdGJMTZSETgHadl4ZR/gIRG/T+FmNsW
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10499"; a="369384606"
X-IronPort-AV: E=Sophos;i="5.95,182,1661842800"; 
   d="scan'208";a="369384606"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2022 13:52:13 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10499"; a="629687638"
X-IronPort-AV: E=Sophos;i="5.95,182,1661842800"; 
   d="scan'208";a="629687638"
Received: from akleen-mobl1.amr.corp.intel.com (HELO [10.212.104.135]) ([10.212.104.135])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2022 13:52:11 -0700
Message-ID: <a4e18a6c-d03a-d4fc-fb7e-d8bf37e85ce0@linux.intel.com>
Date:   Thu, 13 Oct 2022 16:52:09 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH] fs/select: avoid clang stack usage warning
Content-Language: en-US
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Eric Dumazet <edumazet@google.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
References: <20190307090146.1874906-1-arnd@arndb.de>
 <20221006222124.aabaemy7ofop7ccz@google.com>
 <f0dbc406-11b4-90f7-52fd-ce79f842c356@linux.intel.com>
 <CAKwvOdnpMqW_esBd615Fx8VKTfny-yR2PTUejBH0uYkHaL517A@mail.gmail.com>
From:   Andi Kleen <ak@linux.intel.com>
In-Reply-To: <CAKwvOdnpMqW_esBd615Fx8VKTfny-yR2PTUejBH0uYkHaL517A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


>> I wonder if there is a way to disable the warning or increase the
>> threshold just for this function. I don't think attribute optimize would
>> work, but perhaps some pragma?
> Here's what I would have guessed, the pragma approach seems a little broken.
> https://godbolt.org/z/vY7fGYv7f
> Maybe I'm holding it wrong?

Thanks. Looks like the warning setting is not propagated to the point 
where the warning is generated in the backend. Could file a gcc bug on 
that, but yes the solution won't work for now.

-Andi

