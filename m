Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C55AE23EBF8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Aug 2020 13:11:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728299AbgHGLLD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Aug 2020 07:11:03 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:47305 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726159AbgHGLKV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Aug 2020 07:10:21 -0400
Received: from [192.168.1.155] ([95.117.97.82]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1McpaE-1kdt290dOM-00ZwUJ; Fri, 07 Aug 2020 13:09:31 +0200
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
Subject: srvfs: file system for posting open file descriptors into fs
 namespace
Message-ID: <55ef0e9a-fb70-7c4a-e945-4d521180221c@metux.net>
Date:   Fri, 7 Aug 2020 13:09:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: tl
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:aYH5qUaztN8iXaCem72LGjZk06I3Aw5dDKBfrw6qDZ1UnOmvPQx
 ObESaggefqvn96vKY6IXgUGbWqXXxHzU2BEOMTeV53LmkvC8Ns4L6fdZkUMo4jRoLcGE539
 YCj/zPMzCDckPTPpOIkd6qye3h4yOaQopx3Wwn7ErZj1G6qjtKrXLutvQ4k/TmJd04jzTPE
 YUja84VuOmEglQ0ASnfnQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Jw4ZP2u63oM=:eTZKKOWShd2aXxkZBLJ6hb
 jhzcZNQhxsKnk+wMJxHXUOiKDDw5loMmoo5/7yOqagBwQ/iAh5cxzsAQWA1fPjMW/b9RrkPU+
 JZfpRXst4VfACNJvV6gsCNvh/SmQlFNLYE6GcaqcjaBRwZpRpMSREIMKQT+vV+LrB4G3uKbRV
 x93zM6N9MEvOJKl7RpKBiBSu7+bS4bYxeslL6r2Ux5DzmNGcWbqLgvuNF7tjsVtg57Vxe6TfU
 K48l/t63NlSeeqVOSwyTLub95fS6AZ8NCKE64KhDtemPfINoPtnPM5ouiGHUE7vzim9fUvxCG
 2p5fY462b0uYowV0FjhmoUIN6KG2T/zPtHOc2M9TIs3kwiqFg3AR+RjZe4J2pCCUfygFbctpp
 NrAfsx+teNoMaCMxue8UKuV0AtXFJIgdt7QawRHPrQSq5qN8o+joIWE3lgL+JcJsgw+ub1H6i
 9sijwcHU7F0dLmUDoT3FLEuc0Hmg2LMAWRcwFR4/M+O62lOlO4GQ1hAtujk8VFuhveX2n/W67
 KPf8CPeKIKdYkm4AAxLwfScQaTaxkGLEErkSqXBlF9/UPkiNbYFVeKJBS8gP1jjeB9sSiW6tq
 T+TAAuV38VgBZMC+up3BgWmg2ICuTsJqT+1T9Qgg5kavYgOoJgpJWgxH3OoV9/u+by/49IamE
 zUvBEW12VgUAbACU/bo3VUq/9cH3VioI8OIYoDahPVSVMI21mUuVdxf4Y8mOlg/IJJhpVk/z5
 1wZyjziFRs3pzSX00OWTBadOZKRrJzF+maDJHLqi98N2tFHKaibWzg+aIBT/n0cyVJxJVsnZR
 lbClW72tLWSE/RMo+WMPRWhuLKeVe0RQxWruPa5AffJC2QHGEUX+vH0Tqz7uKib8RWRpG1U
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello folks,


here's the first version of my "srvfs" implementation - a synthentic
filesystem which allows a process to "publish" an open file descriptor
into the file system, so other processes can continue from there, with
whatever state the fd is already in.

This is a concept from Plan9. The main purpose is allowing applications
"dialing" some connection, do initial handshakes (eg. authentication)
and then publish the connection to other applications, that now can now
make use of the already dialed connection.

I'm currently developing it out-of-tree - will convert it to patches,
once it reached a stable state.

https://github.com/metux/linux-srvfs-oot


Some quick background pointers on how it works on Plan9:
http://man.cat-v.org/plan_9/4/exportfs
https://9fans.github.io/plan9port/man/man3/dial.html



have fun,

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
