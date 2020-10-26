Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D50E29857F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Oct 2020 03:09:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1421348AbgJZCJy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 25 Oct 2020 22:09:54 -0400
Received: from mga07.intel.com ([134.134.136.100]:14867 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1419665AbgJZCJx (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 25 Oct 2020 22:09:53 -0400
IronPort-SDR: GplOTd0w9Bs6qgcCPJ3nw/Yh6s3sPUbXGpuWr0foXjpB9Tc3xV8sIltMKG3Ksr9olCuq8kN0Jk
 4JeUP27bbkUA==
X-IronPort-AV: E=McAfee;i="6000,8403,9785"; a="232059519"
X-IronPort-AV: E=Sophos;i="5.77,417,1596524400"; 
   d="scan'208";a="232059519"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2020 19:09:52 -0700
IronPort-SDR: /knjrN/0mMNUODiflbSaDq4Eyq+oyr8Posk3QJPSaUdEHHSMW8zzrP5GWP2I269dFuyftblUQ8
 SYlsIc53I8bg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,417,1596524400"; 
   d="scan'208";a="303404510"
Received: from lkp-server01.sh.intel.com (HELO cda15bb6d7bd) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 25 Oct 2020 19:09:51 -0700
Received: from kbuild by cda15bb6d7bd with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kWrxG-000184-Ol; Mon, 26 Oct 2020 02:09:50 +0000
Date:   Mon, 26 Oct 2020 10:09:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     kbuild-all@lists.01.org, linux-fsdevel@vger.kernel.org
Subject: [vfs:work.epoll 17/27] fs/eventpoll.c:1629:3: warning: Assignment of
 function parameter has no effect outside the function. Did you forget
 dereferencing
Message-ID: <202010261043.dPTrCpUD-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.epoll
head:   319c15174757aaedacc89a6e55c965416f130e64
commit: ff07952aeda8563d5080da3a0754db83ed0650f6 [17/27] ep_send_events_proc(): fold into the caller
compiler: h8300-linux-gcc (GCC) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


"cppcheck warnings: (new ones prefixed by >>)"
>> fs/eventpoll.c:1629:3: warning: Assignment of function parameter has no effect outside the function. Did you forget dereferencing it? [uselessAssignmentPtrArg]
     events++;
     ^

vim +1629 fs/eventpoll.c

  1565	
  1566	static int ep_send_events(struct eventpoll *ep,
  1567				  struct epoll_event __user *events, int maxevents)
  1568	{
  1569		struct epitem *epi, *tmp;
  1570		LIST_HEAD(txlist);
  1571		poll_table pt;
  1572		int res = 0;
  1573	
  1574		init_poll_funcptr(&pt, NULL);
  1575	
  1576		ep_start_scan(ep, 0, false, &txlist);
  1577	
  1578		/*
  1579		 * We can loop without lock because we are passed a task private list.
  1580		 * Items cannot vanish during the loop because ep_scan_ready_list() is
  1581		 * holding "mtx" during this call.
  1582		 */
  1583		lockdep_assert_held(&ep->mtx);
  1584	
  1585		list_for_each_entry_safe(epi, tmp, &txlist, rdllink) {
  1586			struct wakeup_source *ws;
  1587			__poll_t revents;
  1588	
  1589			if (res >= maxevents)
  1590				break;
  1591	
  1592			/*
  1593			 * Activate ep->ws before deactivating epi->ws to prevent
  1594			 * triggering auto-suspend here (in case we reactive epi->ws
  1595			 * below).
  1596			 *
  1597			 * This could be rearranged to delay the deactivation of epi->ws
  1598			 * instead, but then epi->ws would temporarily be out of sync
  1599			 * with ep_is_linked().
  1600			 */
  1601			ws = ep_wakeup_source(epi);
  1602			if (ws) {
  1603				if (ws->active)
  1604					__pm_stay_awake(ep->ws);
  1605				__pm_relax(ws);
  1606			}
  1607	
  1608			list_del_init(&epi->rdllink);
  1609	
  1610			/*
  1611			 * If the event mask intersect the caller-requested one,
  1612			 * deliver the event to userspace. Again, ep_scan_ready_list()
  1613			 * is holding ep->mtx, so no operations coming from userspace
  1614			 * can change the item.
  1615			 */
  1616			revents = ep_item_poll(epi, &pt, 1);
  1617			if (!revents)
  1618				continue;
  1619	
  1620			if (__put_user(revents, &events->events) ||
  1621			    __put_user(epi->event.data, &events->data)) {
  1622				list_add(&epi->rdllink, &txlist);
  1623				ep_pm_stay_awake(epi);
  1624				if (!res)
  1625					res = -EFAULT;
  1626				break;
  1627			}
  1628			res++;
> 1629			events++;
  1630			if (epi->event.events & EPOLLONESHOT)
  1631				epi->event.events &= EP_PRIVATE_BITS;
  1632			else if (!(epi->event.events & EPOLLET)) {
  1633				/*
  1634				 * If this file has been added with Level
  1635				 * Trigger mode, we need to insert back inside
  1636				 * the ready list, so that the next call to
  1637				 * epoll_wait() will check again the events
  1638				 * availability. At this point, no one can insert
  1639				 * into ep->rdllist besides us. The epoll_ctl()
  1640				 * callers are locked out by
  1641				 * ep_scan_ready_list() holding "mtx" and the
  1642				 * poll callback will queue them in ep->ovflist.
  1643				 */
  1644				list_add_tail(&epi->rdllink, &ep->rdllist);
  1645				ep_pm_stay_awake(epi);
  1646			}
  1647		}
  1648		ep_done_scan(ep, 0, false, &txlist);
  1649	
  1650		return res;
  1651	}
  1652	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
