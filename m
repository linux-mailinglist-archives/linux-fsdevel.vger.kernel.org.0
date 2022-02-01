Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5642F4A667F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Feb 2022 21:54:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231216AbiBAUyr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Feb 2022 15:54:47 -0500
Received: from mout.perfora.net ([74.208.4.194]:37099 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242571AbiBAUyc (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Feb 2022 15:54:32 -0500
Received: from [10.93.3.78] ([206.193.5.9]) by mrelay.perfora.net (mreueus002
 [74.208.5.2]) with ESMTPSA (Nemesis) id 0M39Wb-1mPVVW2xOR-00sucP; Tue, 01 Feb
 2022 21:54:09 +0100
To:     dalias@libc.org
Cc:     ariadne@dereferenced.org, ebiederm@xmission.com,
        keescook@chromium.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk
References: <20220126132729.GA7942@brightrain.aerifal.cx>
Subject: Re: [PATCH] fs/exec: require argv[0] presence in do_execveat_common()
Reply-To: 20220126132729.GA7942@brightrain.aerifal.cx
From:   hypervis0r <hypervis0r@phasetw0.com>
Message-ID: <e166bc39-4d3e-ff03-6b14-3a05a487acc3@phasetw0.com>
Date:   Tue, 1 Feb 2022 12:54:08 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20220126132729.GA7942@brightrain.aerifal.cx>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Provags-ID: V03:K1:XmjLVKZFEUDfEUNA/RKZbOxxM75jIPCUSbfld6c3g1t9YUgJ8aT
 L25f/+7Sd/2ekS4JobqXJMsop+ggDacZLHdw2veZtEN0d35ovRfwYpNWGOy5jZy31g9sSFm
 pmCDNHHDa5YF669+CX7svj/ACBtvvHjJ96Dopx1gG0oejvbVoiBbNZKP9XCcL7ozcOs7tQp
 QtM85Ad26cC+fX2fWNJwQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:dK0njNiz0ps=:ykgJZuiKj6dn/nIkZJh4w7
 Rn4XETX9bhxWEYlO8S6vnic1lCccaregkglAYHcr2x4oMIUvYFHbaaeHT6XicnAvlQEKtZxUm
 DVm+/8ew6b2MEtd5jz2y38HCCWjRmvuL+Q4k4ti9gJjvTjjd269ayj9rusJsGjM+TtHz3wirI
 +51AlVHmsnLh9kkRD1JVO+u+KNOOhls9DDRFGnFSktBbSAuJp953d2a+tdfWRzSwru9lmUzn6
 TdEDOkwIrOADaI3YkJEvRfF7ZQWqPuMOi+PBht0SDfuFHYyGdXlCiY3QW6mjjM0Z7vOp8GlSC
 z/pH2EcSJSqmH0MEZq8DFVkIPrN16nli2PpnDG37sc93MVF4Z9lUSS8noC9eV9J2YHQwLeFwo
 GRnwONr5rPZcDEaLyfUlnIcPI1RakJc1BGwfvDyZugr/FrdXpB/i+ZyDCH6SQ3OaVXqxQW6cM
 DeWoiB4nxnE++ZZBm8EjehzgtKSHS7a35jjdNtGfbjV9xzrUj2SJPH9mzpatHYNqiRNZMqXAV
 NEtkwmGwZlz4QtAwyRygwpKqmhHWhhctHb4FYktbLW8HrzmWGbhQsQPD6vc+JQ5+Sm9DWgEuQ
 /lKpMV2U5tXGK3LjltOeDNMXZCDnrOt47Tn/7vGHCjJbX4l5Afsxs1aGM1rzTYSamjJ4s+s2s
 56xjjskE3/R9jZC+ePUF1Crn1kLJXhz59laA5NpifKYbbmuSC7XL4CCo+YJIGC2gPGkF9I8vS
 Zq4OUubXwvgVbZf4
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> I'm not really opposed  to attempting to change this with consensus
> (like, actually  proposing it on the Austin Group tracker), but a less
> invasive change would be  just enforcing it for the case where exec is
> a privilege boundary  (suid/sgid/caps). There's really no motivation
> for changing  longstanding standard behavior in a
> non-privilege-boundary  case.

I don't really see it as a matter of "maintaining standard behavior".

there are very little uses for this ABI feature to be present and only 
serves to make applications harder to port between Linux and other *nix 
systems. The pros (major vulnerabilities like CVE-2021-4034) outweigh 
the cons (minor userland ABI change that only affects shellcode on 
shell-storm.org) in this particular scenario, and I am all for this patch.
